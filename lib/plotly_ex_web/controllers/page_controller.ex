defmodule PlotlyExWeb.PageController do
  use PlotlyExWeb, :controller

  def show(conn, %{"id" => id}) do
    IO.puts(id)
    {^id, data, layout, options} = PlotlyEx.get_plot(id)

    render(conn, "index.html",
      plotly_data: Poison.encode!(data),
      plotly_layout: Poison.encode!(layout),
      plotly_options: Poison.encode!(options)
    )
  end
end
