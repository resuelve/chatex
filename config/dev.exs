import Config

config :chatex, host: System.get_env("GOOGLE_CHAT_URL")
config :chatex, token: System.get_env("BOT_TOKEN")
config :chatex, client_email: System.get_env("BOT_CLIENT_EMAIL")

config :goth,
  json: System.get_env("GOOGLE_CREDENTIALS") |> File.read!
