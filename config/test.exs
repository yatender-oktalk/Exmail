use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exmail, ExmailWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :exmail, Exmail.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ok",
  password: "maxx",
  database: "exmail_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
