defmodule Clock.Adapter.Target do
  defstruct [:time, :spi]
  alias Clock.Core
  alias Circuits.SPI

  def open(bus, time) do
    :timer.send_interval(1_000, :tick)

    bus = bus || hd(SPI.bus_names())
    {:ok, spi} = SPI.open(bus)
    %__MODULE__{time: time, spi: spi}
  end

  def show(adapter, time) do
    adapter
    |> Map.put(:time, time)
    |> transfer()
  end

  defp transfer(adapter) do
    bytes = adapter.time |> Core.new() |> Core.to_leds(:bytes)
    SPI.transfer(adapter.spi, bytes)
    adapter
  end
end
