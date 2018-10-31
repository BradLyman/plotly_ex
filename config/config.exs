use Mix.Config

config :plotly_ex, PlotlyExWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "secret",
  render_errors: [view: PlotlyExWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlotlyEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

import_config "#{Mix.env}.exs"
