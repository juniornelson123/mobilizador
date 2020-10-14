# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# use Pow.Ecto.Context, otp_app: :mobilizador

config :mobilizador, :pow,
  user: Mobilizador.Users.User,
  repo: Mobilizador.Repo,
  web_module: MobilizadorWeb

config :mobilizador,
  ecto_repos: [Mobilizador.Repo]

# Configures the endpoint
config :mobilizador, MobilizadorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sa+nGKzzmqrXhuEw/AK+GnwBOVXmAf2F9re+nlvEGGiURGxSA3dsDMOSNzFL8Mub",
  render_errors: [view: MobilizadorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mobilizador.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "Q2h2e5TD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
