defmodule Chatex.Service.Spaces.Members do
  @moduledoc """
  Helper para miembros de spaces.
  """

  import Chatex, only: [request: 3]

  @doc """
  Lista todos los miembros de un canal.
  """
  @spec list(String.t, integer, list, String.t | nil) :: tuple
  def list(room, pageSize \\ 100, acc \\ [], pageToken \\ nil) do
    case request(:get, "spaces/#{room}/members?pageSize=#{pageSize}&pageToken=#{pageToken}", "") do
      {:ok, %{"memberships" => members, "nextPageToken" => ""}} ->
        {:ok, acc ++ members}
      {:ok, %{"memberships" => members, "nextPageToken" => next_page_token}} ->
        list(room, pageSize, acc ++ members, next_page_token)
      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Lista los miembros de un canal excluyendo usuarios anonimos.
  """
  @spec list_active(String.t, integer) :: tuple
  def list_active(room, pageSize \\ 100) do
    case list(room, pageSize) do
      {:ok, members} ->
        {:ok, Enum.filter(members, fn(m) -> m["member"]["displayName"] !=
                                                          "Anonymous User" end)}
      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Lista un atributo de los miembros activos del canal.
  """
  @spec list_attribute(String.t, String.t, integer) :: tuple
  def list_attribute(room, attribute \\ "displayName", pageSize \\ 100) do
    case list_active(room, pageSize) do
      {:ok, members} ->
        {:ok, Enum.reduce(members, "", fn(m, acc) -> acc <>
                                      "- #{m["member"]["#{attribute}"]}\n" end)}
      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Obtiene el atributo de un miembro aleatorio.
  """
  @spec random(String.t, String.t, integer) :: tuple
  def random(room, attribute \\ "name", pageSize \\ 100) do
    case list_active(room, pageSize) do
      {:ok, members} ->
        {:ok, Enum.random(members)["member"]["#{attribute}"]}
      {:error, error} ->
        {:error, error}
    end
  end
end
