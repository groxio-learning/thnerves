defmodule Blinker.LED do
  alias Circuits.GPIO
  defstruct [:led, :on]

  def open(pin) do
    message("Opening #{pin}")
    {:ok, led} = GPIO.open(pin, :output)
    led
  end

  def on(led) do
    message("On: #{inspect(led)}")
    GPIO.write(led, 1)
    led
  end

  def off(led) do
    message("Off: #{inspect(led)}")
    GPIO.write(led, 0)
    led
  end

  def message(message) do
    # Warning: IO.puts in hardware can be unpredictable
    IO.puts(message)
  end
end
