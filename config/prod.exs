import Config

config :chatex, host: "${GOOGLE_CHAT_URL}"
config :chatex, token: "${BOT_TOKEN}"
config :chatex, client_email: "${BOT_CLIENT_EMAIL}"

config :goth,
  json: "${GOOGLE_CREDENTIALS}" |> File.read!
