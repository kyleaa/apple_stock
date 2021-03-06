use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :apple_stock, AppleStock.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: {:system, "URL_HOST"}, path: System.get_env("URL_PATH"), port: {:system, "URL_PORT"}],
  cache_static_manifest: "priv/static/manifest.json"

# Do not print debug messages in production
config :logger, level: :info


# Configure your database
config :apple_stock, AppleStock.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("APPLE_STOCK_DB_USER") || "postgres",
  password: System.get_env("APPLE_STOCK_DB_PASS") || "postgres",
  database: System.get_env("APPLE_STOCK_DB_NAME") || "apple_stock_prod",
  hostname: System.get_env("APPLE_STOCK_DB_HOST") || "postgres",
  pool_size: 20


config :apple_stock, AppleStock.Endpoint,
  secret_key_base: System.get_env("APPLE_STOCK_KEY_BASE")

config :quantum, cron: [
  "*/2 * * * *": {AppleStock.AlarmEngine, :process_alarms}
]
