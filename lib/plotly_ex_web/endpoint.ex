defmodule PlotlyExWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :plotly_ex

  plug Plug.Static,
    at: "/", from: :plotly_ex, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_plotly_ex_key",
    signing_salt: "MaX1hErL"

  plug PlotlyExWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = 4000
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
