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
      {:ok, value} when value in [nil, ""] ->
        _children(:gcloud_credentials)

      {:ok, "FAKE_GOOGLE_ACCOUNT_ID"} ->
        []

      {:ok, _google_service_account_id} ->
        Logger.info("Chatex init with service_account_id")

        [{Goth, name: Chatex.Goth}]

      _ ->
        _children(:gcloud_credentials)
    end
  end

  @spec _children(atom()) :: any()
  defp _children(:gcloud_credentials) do
    case Application.fetch_env(:chatex, :gcloud_credentials) do
      {:ok, value} when value in [nil, ""] ->
        Logger.error("Chatex not found a value for env")

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

      invalid_value ->
        Logger.error("Chatex not found a valid value for env:#{invalid_value}")

        invalid_value
    end
  end
end
