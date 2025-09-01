import Config

# credentials =
#   case System.get_env("GCHAT_CREDENTIALS") do
#     {:ok, credentials} -> credentials
#     :error -> System.get_env("GOOGLE_CREDENTIALS")
#   end

config :chatex, gcloud_credentials: System.get_env("GCHAT_CREDENTIALS")

config :chatex, service_account_id: System.get_env("GCHAT_ACCOUNT_ID")
