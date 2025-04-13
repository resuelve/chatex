defmodule Chatex.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = _children(Application.get_env(:chatex, :gcloud_credentials))

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  defp _children("FAKE_GOOGLE_CREDENTIALS"), do: []

  defp _children(credentials) do
    source = {
      :service_account,
      credentials |> Base.decode64!() |> Jason.decode!(),
      scopes: ["https://www.googleapis.com/auth/chat.bot"]
    }

    [{Goth, name: Chatex.Goth, source: source}]
  end
end
