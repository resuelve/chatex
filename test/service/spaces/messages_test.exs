defmodule Chatex.Service.Spaces.MessagesTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Service.Spaces.Messages
  alias Goth.Token

  @message %{
    "annotations" => [],
    "argumentText" => "test",
    "cards" => [],
    "createTime" => "2018-07-25T23:24:03.938975Z",
    "fallbackText" => "",
    "name" => "spaces/hZmKQAAAAAE/messages/HP0p_8gQNi4.HP0p_8gQNi4",
    "previewText" => "",
    "sender" => %{
      "displayName" => "",
      "name" => "users/111714068150425821220",
      "type" => "BOT"
    },
    "space" => %{
      "displayName" => "⚙ Ingeniería",
      "name" => "spaces/hZmKQAAAAAE",
      "type" => "ROOM"
    },
    "text" => "Hola",
    "thread" => %{"name" => "spaces/hZmKQAAAAAE/threads/HP0p_8gQNi4"}
  }

  @update_message %{
    "annotations" => [],
    "argumentText" => "actualizado",
    "cards" => [],
    "createTime" => "2018-07-25T23:24:03.938975Z",
    "fallbackText" => "",
    "name" => "spaces/hZmKQAAAAAE/messages/HP0p_8gQNi4.HP0p_8gQNi4",
    "previewText" => "",
    "sender" => %{
      "displayName" => "",
      "name" => "users/111714068150425821220",
      "type" => "BOT"
    },
    "space" => %{
      "displayName" => "⚙ Ingeniería",
      "name" => "spaces/hZmKQAAAAAE",
      "type" => "ROOM"
    },
    "text" => "actualizado",
    "thread" => %{"name" => "spaces/hZmKQAAAAAE/threads/HP0p_8gQNi4"}
  }

  test "create/2 create message" do
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
          {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@message)}}
        end]
      }
    ]) do
      assert Messages.create("hZmKQAAAAAE", %{text: "hola"}) == {:ok, @message}
    end
  end

  test "update/3 update message" do
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
          {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@update_message)}}
        end]
      }
    ]) do
      assert Messages.update("hZmKQAAAAAE/messages/HP0p_8gQNi4.HP0p_8gQNi4",
                        "text", %{text: "actualizado"}) == {:ok, @update_message}
    end
  end
end
