defmodule Chatex.Service.Spaces do
  @moduledoc """
  Helper para spaces.
  """

  import Chatex, only: [request: 3]

  @doc """
  Lista los espacios en los cuales se agregado al bot.
  """
  @spec list(integer, list, String.t | nil) :: tuple
  def list(pageSize \\ 100, acc \\ [], pageToken \\ "") do
    case request(:get, "spaces?pageSize=#{pageSize}&pageToken=#{pageToken}", "") do
      {:ok, %{"spaces" => spaces, "nextPageToken" => ""}} ->
        {:ok, acc ++ spaces}
      {:ok, %{"spaces" => spaces, "nextPageToken" => nextPageToken}} ->
        list(pageSize, acc ++ spaces, nextPageToken)
      {:error, error} ->
        {:error, error}
    end
  end
end
