defmodule Chatex.MessagesTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Messages

  @message %{
    "argumentText" => "Hola",
    "createTime" => "2025-04-13T01:10:35.951263Z",
    "name" => "spaces/hZmKQAAAAAE/messages/HP0p_8gQNi4.HP0p_8gQNi4",
    "sender" => %{
      "displayName" => "Coyote",
      "name" => "users/111714068150425821220",
      "type" => "BOT"
    },
    "space" => %{
      "lastActiveTime" => "2025-04-10T19:09:34.667119Z",
      "membershipCount" => %{"joinedDirectHumanUserCount" => 1},
      "name" => "spaces/hZmKQAAAAAE",
      "singleUserBotDm" => true,
      "spaceHistoryState" => "HISTORY_ON",
      "spaceThreadingState" => "UNTHREADED_MESSAGES",
      "spaceType" => "DIRECT_MESSAGE",
      "spaceUri" => "https://chat.google.com/dm/hZmKQAAAAAE?cls=11",
      "type" => "DM"
    },
    "text" => "hola",
    "thread" => %{"name" => "spaces/hZmKQAAAAAE/threads/WbrhuiH7Duw"}
  }

  @update_message %{
    "argumentText" => "hola actualizado",
    "createTime" => "2025-04-13T01:10:35.951263Z",
    "formattedText" => "hola actualizado",
    "lastUpdateTime" => "2025-04-13T01:36:41.986510Z",
    "name" => "spaces/hZmKQAAAAAE/messages/WbrhuiH7Duw.WbrhuiH7Duw",
    "sender" => %{
      "displayName" => "Coyote",
      "name" => "users/108948324668249816295",
      "type" => "BOT"
    },
    "space" => %{
      "lastActiveTime" => "2025-04-13T01:10:35.951263Z",
      "membershipCount" => %{"joinedDirectHumanUserCount" => 1},
      "name" => "spaces/hZmKQAAAAAE",
      "singleUserBotDm" => true,
      "spaceHistoryState" => "HISTORY_ON",
      "spaceThreadingState" => "UNTHREADED_MESSAGES",
      "spaceType" => "DIRECT_MESSAGE",
      "spaceUri" => "https://chat.google.com/dm/hZmKQAAAAAE?cls=11",
      "type" => "DM"
    },
    "text" => "hola actualizado",
    "thread" => %{"name" => "spaces/hZmKQAAAAAE/threads/WbrhuiH7Duw"}
  }

  test "create message" do
    with_mocks([
      {
        Goth,
        [:passthrough],
        [
          fetch: fn _module ->
            {:ok, %{token: ""}}
          end
        ]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!(@message)}}
          end
        ]
      }
    ]) do
      assert {:ok, @message} == Messages.create("hZmKQAAAAAE", "hola")
    end
  end

  test "update message" do
    with_mocks([
      {
        Goth,
        [:passthrough],
        [
          fetch: fn _module ->
            {:ok, %{token: ""}}
          end
        ]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!(@update_message)}}
          end
        ]
      }
    ]) do
      assert {:ok, @update_message} ==
               Messages.update("hZmKQAAAAAE", "HP0p_8gQNi4.HP0p_8gQNi4", "actualizado", "text")
    end
  end
end
