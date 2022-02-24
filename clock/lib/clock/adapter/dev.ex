defmodule Clock.Adapter.Dev do
  defstruct [:time]
  require Logger
  alias Clock.Core

  def open(_bus \\ nil, time \\ Time.utc_now()) do
    :timer.send_interval(1_000, :tick)
    %__MODULE__{time: time}
  end

  def show(adapter, time) do
    adapter
    |> Map.put(:time, time)
    |> log
  end

  defp log(adapter) do
    face = adapter.time |> Core.new() |> Core.to_leds(:pretty)
    Logger.debug("Clock face: #{face}")
    adapter
  end
end
