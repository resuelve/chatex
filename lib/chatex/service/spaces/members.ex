defmodule Chatex.Service.Spaces.Members do
  @moduledoc """
  Helper para miembros de spaces.
  """

  import Chatex, only: [request: 3]

  @doc """
  Lista los miembros de un canal.
  """
  @spec list(String.t, String.t, list, String.t | nil) :: tuple
  def list(room, pageSize \\ 100, acc \\ [], pageToken \\ nil) do
    case request(:get, "spaces/#{room}/members?pageSize=#{pageSize}&pageToken=#{pageToken}", "") do
      {:ok, %{"memberships" => members, "nextPageToken" => ""}} ->
        members =
          acc ++ members
          |> Enum.filter(fn(m) -> m["member"]["displayName"] != "Anonymous User" end)

        {:ok, members}
      {:ok, %{"memberships" => members, "nextPageToken" => nextPageToken}} ->
        list(room, pageSize, nextPageToken, acc ++ members)
      {:error, error} ->
        {:error, error}
    end
  end
end
