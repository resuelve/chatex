defmodule Chatex.Spaces do
  @moduledoc """
  Helper para spaces.
  """

  import Chatex, only: [request: 3]

  @doc """
  Obtiene un rango de espacios en los cuales se ha agregado al bot y
  puede filtrar una lista de keys dadas para devolver una respuesta
  más limpia.
  """
  @spec paginate(integer, String.t(), list) :: tuple
  def paginate(pageSize \\ 100, page_token \\ "", keys \\ []) do
    case request(:get, "spaces?pageSize=#{pageSize}&pageToken=#{page_token}", "") do
      {:ok, %{"spaces" => spaces, "nextPageToken" => next_page_token}} ->
        {:ok,
         %{
           data: _take_keys(spaces, keys),
           next_page_token: next_page_token
         }}

      {:ok, %{"spaces" => spaces}} ->
        {:ok,
         %{
           data: _take_keys(spaces, keys),
           next_page_token: nil
         }}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Obtiene un rango de los miembros de un canal.
  """
  @spec members(String.t(), integer, String.t(), list, boolean) :: tuple
  def members(room, pageSize \\ 100, page_token \\ "", keys \\ [], anonymous? \\ false) do
    case request(:get, "spaces/#{room}/members?pageSize=#{pageSize}&pageToken=#{page_token}", "") do
      {:ok, %{"memberships" => members, "nextPageToken" => next_page_token}} ->
        {:ok,
         %{
           data: members |> _incluye_anonymous?(anonymous?) |> _take_keys(keys),
           next_page_token: next_page_token
         }}

      {:ok, %{"memberships" => members}} ->
        {:ok,
         %{
           data: members |> _incluye_anonymous?(anonymous?) |> _take_keys(keys),
           next_page_token: nil
         }}

      {:ok, data} when map_size(data) == 0 ->
        {:ok, %{data: [], next_page_token: nil}}

      {:error, error} ->
        {:error, error}
    end
  end

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  @spec _take_keys(list, list) :: list
  defp _take_keys(data, keys) when keys == [], do: data
  defp _take_keys(data, keys), do: Enum.map(data, &Map.take(&1, keys))

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  @spec _incluye_anonymous?(list, boolean) :: list
  defp _incluye_anonymous?(members, true), do: members

  defp _incluye_anonymous?(members, false) do
    Enum.filter(members, &(&1["member"]["displayName"] != "Anonymous User"))
  end
end
