# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :deploy,
  ecto_repos: [Deploy.Repo]

# Configures the endpoint
config :deploy, DeployWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e/dSMaZBo4zcoP+4pnu7lGjYFY7ESV/Mjy0iRQ2tbZb+aYZ4H+vhnhdzWeA5MmPX",
  render_errors: [view: DeployWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Deploy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
