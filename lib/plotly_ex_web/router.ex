defmodule PlotlyExWeb.Router do
  use PlotlyExWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", PlotlyExWeb do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/plots", PageController, only: [:show])
  end
end
