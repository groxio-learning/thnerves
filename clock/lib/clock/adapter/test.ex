defmodule Clock.Adapter.Test do
  defstruct [:time, bits: [], spi: :unused]
  alias Clock.Core

  def open(_bus \\ nil, time \\ Time.utc_now()) do
    %__MODULE__{time: time}
  end

  def show(adapter, time) do
    adapter
    |> Map.put(:time, time)
    |> concat
  end

  defp concat(adapter) do
    bits = adapter.time |> Core.new() |> Core.to_leds(:none)
    %{adapter | bits: [bits | adapter.bits]}
  end
end
