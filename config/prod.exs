import Config

config :chatex, gcloud_credentials: System.get_env("GCHAT_CREDENTIALS")

config :chatex, service_account_id: System.get_env("GCHAT_ACCOUNT_ID")
