import Config

credentials =
  case System.fetch_env("GCHAT_CREDENTIALS") do
    {:ok, credentials} -> credentials
    :error -> System.fetch_env!("GOOGLE_CREDENTIALS")
  end

config :chatex, gcloud_credentials: credentials
