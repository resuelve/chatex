import Config

config :chatex, host: "api.dialogflow.com"
config :chatex, bot: "LBot"
config :chatex, client_email: "client-access@lbot-170198.iam.gserviceaccount.com"

config :goth,
  json:
    "[{\"type\": \"test_service_account\",\"project_id\": \"resuelve-1819\",\"private_key_id\": \"19011998\"," <>
      "\"private_key\": \"-----BEGIN PRIVATE KEY-----fakekey-----END PRIVATE KEY-----\"," <>
      "\"client_email\": \"c_blanco@resuelve-1819.iam.gserviceaccount.com\"," <>
      "\"client_id\": \"19011998\",\"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\"," <>
      "\"token_uri\": \"https://accounts.google.com/o/oauth2/token\"," <>
      "\"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\"client_x509_cert_url\":" <>
      "\"https://www.googleapis.com/robot/v1/metadata/x509/c_blanco%40resuelve-1819.iam.gserviceaccount.com\"}]"
