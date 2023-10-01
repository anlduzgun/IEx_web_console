defmodule WsTerminalTest do
  use ExUnit.Case
  doctest WsTerminal

  test "greets the world" do
    assert WsTerminal.hello() == :world
  end
end
