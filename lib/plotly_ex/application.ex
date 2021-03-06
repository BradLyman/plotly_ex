defmodule PlotlyEx.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(PlotlyExWeb.Endpoint, []),
      worker(PlotlyEx.Table, [])
    ]

    opts = [strategy: :one_for_one, name: PlotlyEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PlotlyExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
