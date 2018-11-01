defmodule PlotlyEx do
  @moduledoc """
  PlotlyEx is a bare-minimum in-between for elixir and Plotly.js.
  """

  @table Plots

  @doc """
  Create a plot with a list of data maps, a format map, and an options app.
  The maps are just directly serialized into JSON and passed to the plotly.js
  interface.

  ## Example

  The original javascript example

      Plotly.plot(target,
        [
          {
            x: [1, 2, 3],
            y: [2, -1, 4]
          }
        ],
        {
          title: 'some title'
        },
        {
          responsive: true
        }
      );

  Has the corresponding elixir

      iex> import PlotlyEx
      iex> plot(
      ...>   [
      ...>     %{
      ...>         x: [1, 2, 3],
      ...>         y: [2, -1, 4]
      ...>     }
      ...>   ],
      ...>   {
      ...>     title: "some title"
      ...>   },
      ...>   {
      ...>     responsive: :true
      ...>   }
      ...> )
      localhost:4000/plots/id

  """
  @spec plot([map], map, map) :: no_return
  def plot(data, format \\ %{}, options \\ %{})

  def plot(data = [_entry = %{} | _], format, options) do
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
    |> List.first()
  end

  defp gen_id do
    Integer.to_string(:rand.uniform(100_000_000), 32)
  end
end
