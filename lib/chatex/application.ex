defmodule Chatex.Application do
  @moduledoc false
  use Application

  require Logger

  def start(_type, _args) do
    children = _children()

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  @spec _children :: any()
  defp _children do
    case Application.fetch_env(:chatex, :service_account_id) do
      {:ok, nil} ->
        _children(:gcloud_credentials)

      {:ok, _google_service_account_id} ->
        Logger.info("Chatex init with service_account_id")

        [{Goth, name: Chatex.Goth}]

      error ->
        error
    end
  end

  @spec _children(atom()) :: any()
  defp _children(:gcloud_credentials) do
    case Application.fetch_env(:chatex, :gcloud_credentials) do
      {:ok, nil} ->
        "Value not found for chatex env"

      {:ok, "FAKE_GOOGLE_CREDENTIALS"} ->
        []

      {:ok, credentials} ->
        source = {
          :service_account,
          credentials |> Base.decode64!() |> Jason.decode!(),
          scopes: [
            "https://www.googleapis.com/auth/chat.bot",
            "https://www.googleapis.com/auth/chat.spaces.readonly"
          ]
        }

        Logger.info("Chatex init with service_account")

        [{Goth, name: Chatex.Goth, source: source}]

      error ->
        error
    end
  end
end
