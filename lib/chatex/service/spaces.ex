defmodule Chatex.Service.Spaces do
  @moduledoc """
  Helper para spaces.
  """

  import Chatex, only: [request: 3]

  @doc """
  Lista los espacios en los cuales se ha agregado al bot.
  """
  @spec list(integer, list, String.t() | nil) :: tuple
  def list(pageSize \\ 100, acc \\ [], pageToken \\ "") do
    case request(:get, "spaces?pageSize=#{pageSize}&pageToken=#{pageToken}", "") do
      {:ok, %{"spaces" => spaces, "nextPageToken" => ""}} ->
        {:ok, acc ++ spaces}

      {:ok, %{"spaces" => spaces, "nextPageToken" => next_page_token}} ->
        list(pageSize, acc ++ spaces, next_page_token)

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Lista un atributo de los espacios.
  """
  @spec list_attribute(String.t(), integer) :: tuple
  def list_attribute(attribute \\ "displayName", pageSize \\ 100) do
    case list(pageSize) do
      {:ok, spaces} ->
        {:ok,
         Enum.reduce(spaces, "", fn space, acc ->
           acc <>
             "- #{space["#{attribute}"]}\n"
         end)}

      {:error, error} ->
        {:error, error}
    end
  end
end
