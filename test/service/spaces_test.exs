defmodule Chatex.Service.SpacesTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Service.Spaces
  alias Goth.Token

  @spaces %{
    "spaces" => [
      %{"displayName" => "", "name" => "spaces/66jbaAAAAAE", "type" => "DM"},
      %{"displayName" => "⚙ Ingeniería", "name" => "spaces/hZmKQAAAAAE", "type" => "ROOM"}
    ],
    "nextPageToken" => ""
  }

  test "list/3 list spaces" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn(_url) -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [request: fn(_method, _url, _params, _headers) ->
          {:ok, %HTTPoison.Response{status_code: 200,
                                                body: Poison.encode!(@spaces)}}
        end]
      }
    ]) do
      assert Spaces.list == {:ok, @spaces["spaces"]}
    end
  end

  test "list_attribute/2 list an attribute of the spaces" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn(_url) -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [request: fn(_method, _url, _params, _headers) ->
          {:ok, %HTTPoison.Response{status_code: 200,
                                                body: Poison.encode!(@spaces)}}
        end]
      }
    ]) do
      assert Spaces.list_attribute("displayName") == {:ok, "- \n- ⚙ Ingeniería\n"}
    end
  end
end
