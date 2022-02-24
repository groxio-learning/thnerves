defmodule Blinker.Server do
  alias Blinker.LED
  defstruct [:led, :on, :ticker]
  use GenServer
  @pin 26

  def new(opts) do
    %__MODULE__{
      on: false,
      led: LED.open(opts[:pin] || @pin),
      ticker: opts[:ticker] || (&wait/0)
    }
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts \\ []) do
    send(self(), :blink)
    {:ok, new(opts)}
  end

  def tick(pid \\ __MODULE__) do
    GenServer.call(pid, :tick)
  end

  def handle_info(:blink, blinker) do
    blinker.ticker.()
    {:noreply, blink(blinker)}
  end

  defp blink(%{on: true} = blinker) do
    LED.on(blinker.led)
    %{blinker | on: false}
  end

  defp blink(%{on: false} = blinker) do
    LED.off(blinker.led)
    %{blinker | on: true}
  end

  def wait, do: Process.send_after(self(), :blink, 1000)
end
