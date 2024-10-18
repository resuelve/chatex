defmodule Chatex.Helpers.TokenHelper do
  @moduledoc """
  Helper para facilitar la validación del token de Google Chat.
  """

  require Logger

  @doc """
  Valida que el token sea el mismo que el proporcionado por Google Chat.
  """
  @spec validate(nil | String.t()) :: tuple
  def validate(nil), do: {:error, "Token no encontrado"}
  def validate(send), do: _compare(send, _token())

  # ---------------------------------------------------------------------------
  # Compará el token que llega contra el guardado
  # ---------------------------------------------------------------------------
  defp _compare(send, expected) when send == expected do
    {:ok, "Token valido"}
  end

  defp _compare(send, expected) do
    Logger.info("Token esperado: #{expected}")
    Logger.info("Token enviado: #{send}")

    {:error, "Token inválido"}
  end

  # ---------------------------------------------------------------------------
  # URL de Google chat API.
  # ---------------------------------------------------------------------------
  @spec _token :: String.t()
  defp _token, do: Application.get_env(:chatex, :token)
end
