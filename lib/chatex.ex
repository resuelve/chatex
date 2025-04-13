defmodule Chatex do
  @moduledoc """
  Documentation for Chatex.
  """

  @doc """
  Envía una respuesta generada a google chat.
  """
  @spec request(atom, String.t(), String.t()) :: tuple
  def request(method, path, body) do
    HTTPoison.start()

    case HTTPoison.request(method, _host(path), body, _headers()) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 200..299 ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 400..499 ->
        {:error, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 500 ->
        {:error, Jason.decode!(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Jason.decode!(reason)}
    end
  end

  # ---------------------------------------------------------------------------
  # URL de Google chat API.
  # ---------------------------------------------------------------------------
  @spec _host(String.t()) :: String.t()
  defp _host(path), do: "https://chat.googleapis.com/v1/#{path}"

  # ---------------------------------------------------------------------------
  # Headers de la petición.
  # ---------------------------------------------------------------------------
  @spec _headers :: list
  defp _headers do
    {:ok, %{token: token}} = Goth.fetch(Chatex.Goth)

    [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"}
    ]
  end
end
