defmodule PlotlyEx do
  @moduledoc """
  PlotlyEx is a bare-minimum in-between for elixir and Plotly.js.

  Plots are just maps stored in an ETS table which gets rendered into
  javascript by phoenix.
  """

  @table Plots

  @spec plot([map], map, map) :: no_return
  def plot(data, format \\ %{}, options \\ %{})
  def plot(data = [_entry = %{}| _], format, options) do
    id = gen_id()
    :ets.insert(@table, {id, data, format, options})
    path = PlotlyExWeb.Router.Helpers.page_path(PlotlyExWeb.Endpoint, :show, id)
    "localhost:4000#{path}"
  end
  def plot(entry = %{}, format, options) do
    plot([entry], format, options)
  end

  def get_plot(id) do
    @table
    |> :ets.lookup(id)
    |> List.first
  end

  defp gen_id do
    Integer.to_string(:rand.uniform(100_000_000), 32)
  end

  use GenServer

  def start_link do
    GenServer.start_link(PlotlyEx, [], [])
  end

  @impl true
  def init(_args) do
    :ets.new(@table, [:named_table, :public])
    {:ok, []}
  end
end
