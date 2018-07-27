defmodule Chatex do
  @moduledoc """
  Documentation for Chatex.
  """

  alias Goth.Token

  @doc """
  Envía una respuesta generada a google chat.
  """
  @spec request(atom, String.t, String.t) :: tuple
  def request(method, path, body) do
    HTTPoison.start

    case HTTPoison.request(method, "#{host()}#{path}", body, headers()) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 200..299 ->
        {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 400..499 ->
        {:error, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 500 ->
        {:error, Poison.decode!(body)}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Poison.decode!(reason)}
    end
  end

  # ---------------------------------------------------------------------------
  # URL de Google chat API.
  # ---------------------------------------------------------------------------
  @spec host :: String.t
  defp host, do: Application.get_env(:chatex, :host)

  # ---------------------------------------------------------------------------
  # Headers de la petición.
  # ---------------------------------------------------------------------------
  @spec headers() :: list
  defp headers() do
    email = Application.get_env(:chatex, :client_email)

    {:ok, token} = Token.for_scope({email, "https://www.googleapis.com/auth/chat.bot"})

    [
      {"Authorization", "Bearer #{token.token}"},
      {"Content-Type", "application/json"}
    ]
  end
end
