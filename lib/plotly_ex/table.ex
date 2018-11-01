defmodule PlotlyEx.Table do
  @moduledoc """
  An agent which just exists to keep an ETS table of plot data alive.
  """

  use Agent

  def start_link do
      Agent.start_link(fn ->
        :ets.new(Plots, [:named_table, :public])
      end,
      []
    )
  end
end
