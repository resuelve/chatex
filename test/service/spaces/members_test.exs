defmodule Chatex.Service.Spaces.MembersTest do
  use ExUnit.Case

  import Mock

  alias Chatex.Service.Spaces.Members
  alias Goth.Token

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
    ],
    "nextPageToken" => ""
  }

  test "list/4 list members of a channel" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn _url -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@members)}}
          end
        ]
      }
    ]) do
      assert Members.list("AAAAnZB0gGw") == {:ok, @members["memberships"]}
    end
  end

  test "list_active/2 list members active of a channel" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn _url -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@members)}}
          end
        ]
      }
    ]) do
      assert Members.list_active("AAAAnZB0gGw") ==
               {:ok, [Enum.at(@members["memberships"], 0)]}
    end
  end

  test "list_attribute/3 list an attribute of the active members of the channel" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn _url -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@members)}}
          end
        ]
      }
    ]) do
      assert Members.list_attribute("AAAAnZB0gGw", "displayName") == {:ok, "- Osmara\n"}
    end
  end

  test "random/3 Get the attribute of a random member" do
    with_mocks([
      {
        Token,
        [:passthrough],
        [for_scope: fn _url -> {:ok, %{token: "0xFAKETOKEN_Q="}} end]
      },
      {
        HTTPoison,
        [:passthrough],
        [
          request: fn _method, _url, _params, _headers ->
            {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@members)}}
          end
        ]
      }
    ]) do
      assert Members.random("AAAAnZB0gGw", "name") == {:ok, "users/111714068150425821220"}
    end
  end
end
