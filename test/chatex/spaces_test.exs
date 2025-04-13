defmodule Chatex.SpacesTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Spaces

  @spaces %{
    "spaces" => [
      %{
        "lastActiveTime" => "2019-09-12T17:15:56.327103Z",
        "membershipCount" => %{"joinedDirectHumanUserCount" => 1},
        "name" => "spaces/q6UiRAAAAAE",
        "singleUserBotDm" => true,
        "spaceHistoryState" => "HISTORY_ON",
        "spaceThreadingState" => "UNTHREADED_MESSAGES",
        "spaceType" => "DIRECT_MESSAGE",
        "spaceUri" => "https://chat.google.com/dm/q6UiRAAAAAE?cls=11",
        "type" => "DM"
      },
      %{
        "lastActiveTime" => "2022-05-27T16:38:21.108543Z",
        "membershipCount" => %{"joinedDirectHumanUserCount" => 1},
        "name" => "spaces/AAAAyejWs-I",
        "spaceHistoryState" => "HISTORY_ON",
        "spaceThreadingState" => "UNTHREADED_MESSAGES",
        "spaceType" => "DIRECT_MESSAGE",
        "spaceUri" => "https://chat.google.com/dm/AAAAyejWs-I?cls=11",
        "type" => "ROOM"
      }
    ]
  }

  @members %{
    "memberships" => [
      %{
        "createTime" => "2017-06-30T17:04:09.679910Z",
        "member" => %{
          "displayName" => "Osmara",
          "name" => "users/111714068150425821220",
          "type" => "HUMAN"
        },
        "name" => "spaces/hZmKQAAAAAE/members/111714068150425821220",
        "state" => "JOINED"
      },
      %{
        "createTime" => "2017-01-17T17:04:09.679910Z",
        "member" => %{
          "displayName" => "Anonymous User",
          "name" => "users/114162390084970889572",
          "type" => "HUMAN"
        },
        "name" => "spaces/hZmKQAAAAAE/members/114162390084970889572",
        "state" => "JOINED"
      }
    ]
  }

  test "list spaces" do
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
            {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!(@spaces)}}
          end
        ]
      }
    ]) do
      {:ok, %{data: data, next_page_token: nil}} = Spaces.paginate()

      assert data == @spaces["spaces"]
    end
  end

  test "list members of a channel" do
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
            {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!(@members)}}
          end
        ]
      }
    ]) do
      {:ok, %{data: data, next_page_token: nil}} = Spaces.members("AAAAnZB0gGw")

      [members_without_anonymous | _tail] = @members["memberships"]

      assert data == [members_without_anonymous]
    end
  end
end
