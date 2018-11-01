defmodule PlotlyExWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :plotly_ex

  plug(Plug.Static,
    at: "/",
    from: :plotly_ex,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.Session,
    store: :cookie,
    key: "_plotly_ex_key",
    signing_salt: "MaX1hErL"
  )

  plug(PlotlyExWeb.Router)

  @doc """
  Callback invoked for dynamically configuring the endpoint.
  """
  def init(_key, config) do
    myconfig = [
      http: [port: 4000],
      debug_errors: true,
      code_reloader: true,
      check_origin: false,
      watchers: [],
      live_reload: [
        patterns: [
          ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
          ~r{lib/plotly_ex_web/views/.*(ex)$},
          ~r{lib/plotly_ex_web/templates/.*(eex)$}
        ]
      ],
      url: [host: "localhost"],
      secret_key_base: "secret",
      render_errors: [view: PlotlyExWeb.ErrorView, accepts: ~w(html json)],
      pubsub: [name: PlotlyEx.PubSub, adapter: Phoenix.PubSub.PG2]
    ]

    {:ok, Keyword.merge(config, myconfig)}
  end
end
