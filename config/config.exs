# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :exmail,
  ecto_repos: [Exmail.Repo]

# Configures the endpoint
config :exmail, ExmailWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pUZnuwZiNYNnxSs1XGID3/L5PCWEunF/zxmX+GeeVM2RUT77U9ARSAILgIhS0Mr+",
  render_errors: [view: ExmailWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Exmail.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
