defmodule AdapterTest do
  use ExUnit.Case
  import Clock.Adapter.Test

  test "Tracks time" do
    adapter =
      open(:unused, ~T[20:13:17.304475])
      |> show(~T[01:02:04.0])
      |> show(~T[01:02:05.0])

    [second, first] = adapter.bits

    assert [0, 0, 1 | _rest] = first
    assert [1, 0, 1, 0, 0, 0, 1 | _rest] = second
  end
end
