import Config

credentials =
  case System.get_env("GCHAT_CREDENTIALS") do
    {:ok, value} -> value
    _ -> System.get_env("GOOGLE_CREDENTIALS")
  end

config :chatex, gcloud_credentials: credentials

account_id =
  case System.get_env("GCHAT_ACCOUNT_ID") do
    {:ok, value} ->
      value

    _ ->
      System.get_env("GOOGLE_ACCOUNT_ID")
  end

config :chatex, service_account_id: account_id
