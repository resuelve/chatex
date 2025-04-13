defmodule Chatex.Messages do
  @moduledoc """
  Helper para crud de mensajes.
  """

  import Chatex, only: [request: 3]

  @doc """
  Crea un mensaje.
  """
  @spec create(String.t(), String.t() | map()) :: tuple
  def create("spaces/" <> room, message), do: _create("spaces/#{room}", message)
  def create(room, message), do: _create("spaces/#{room}", message)

  @doc """
  Actualiza un mensaje.
  """
  @spec update(String.t(), String.t(), map) :: tuple
  @spec update(String.t(), String.t(), String.t(), map) :: tuple
  def update(room_with_message_id, mask, updated_message) do
    _update("#{room_with_message_id}?updateMask=#{mask}", updated_message)
  end

  def update(room, message_id, mask, updated_message) do
    _update("spaces/#{room}/messages/#{message_id}?updateMask=#{mask}", updated_message)
  end

  @doc """
  Elimina un mensaje.
  """
  @spec delete(String.t()) :: tuple
  @spec delete(String.t(), String.t()) :: tuple
  def delete(room_with_message_id), do: request(:delete, room_with_message_id, "")

  def delete(room_id, message_id) do
    request(:delete, "spaces/#{room_id}/messages/#{message_id}", "")
  end

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  @spec _create(String.t(), String.t() | map) :: tuple
  defp _create(room, message) when is_binary(message) do
    request(:post, "#{room}/messages", Jason.encode!(%{text: message}))
  end

  defp _create(room, message) do
    request(:post, "#{room}/messages", Jason.encode!(message))
  end

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  @spec _update(String.t(), String.t() | map) :: tuple
  defp _update(room_path, updated_message) when is_binary(updated_message) do
    request(:put, room_path, Jason.encode!(%{text: updated_message}))
  end

  defp _update(room_path, updated_message) do
    request(:put, room_path, Jason.encode!(updated_message))
  end
end
