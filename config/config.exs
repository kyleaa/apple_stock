# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :apple_stock,
  ecto_repos: [AppleStock.Repo]


config :apple_stock, AppleStock.AlarmEngine,
  target_arn: System.get_env("APPLE_STOCK_ALARM_ARN")

# Configures the endpoint
config :apple_stock, AppleStock.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9ifNmRsF37g0JMvwaQYoWly9Q2aC8R0tWilwQiCn57IPfgwCt14pYXbObfV53RXi",
  render_errors: [view: AppleStock.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AppleStock.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
