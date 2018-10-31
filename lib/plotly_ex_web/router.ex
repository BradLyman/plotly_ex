defmodule PlotlyExWeb.Router do
  use PlotlyExWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", PlotlyExWeb do
    pipe_through :browser # Use the default browser stack

    resources "/plots", PageController, only: [:show]
  end
end
