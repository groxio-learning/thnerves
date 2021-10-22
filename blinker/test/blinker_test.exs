defmodule BlinkerTest do
  use ExUnit.Case
  doctest Blinker

  test "greets the world" do
    assert Blinker.hello() == :world
  end
end
