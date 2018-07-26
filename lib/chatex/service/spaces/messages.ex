defmodule Chatex.Service.Spaces.Messages do
  @moduledoc """
  Helper para crud de mensajes.
  """

  import Chatex, only: [request: 3]

  @doc """
  Crea un mensaje.
  """
  @spec create(String.t, String.t) :: tuple
  def create(room, message) do
    request(:post, "spaces/#{room}/messages", Poison.encode!(message))
  end

  @doc """
  Actualiza un mensaje.
  """
  @spec update(String.t, String.t, map) :: tuple
  def update(room, update_mask, message) do
    request(:put, "spaces/#{room}?updateMask=#{update_mask}", Poison.encode!(message))
  end
end
