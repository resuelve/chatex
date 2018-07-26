defmodule Chatex.Service.Spaces.MembersTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Service.Spaces.Members
  alias Goth.Token

  @members %{
    "memberships" => [%{
       "createTime" => "2017-10-03T17:04:09.679910Z",
       "member" => %{
         "displayName" => "Osmara",
         "name" => "users/111714068150425821220",
         "type" => "HUMAN"
       },
       "name" => "spaces/hZmKQAAAAAE/members/111714068150425821220",
       "state" => "JOINED"
    }],
    "nextPageToken" => ""
  }

  test "list/4 list members of a channel" do
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
          {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@members)}}
        end]
      }
    ]) do
      assert Members.list("AAAAnZB0gGw") == {:ok, @members["memberships"]}
    end
  end
end
