defmodule AppwriteElixirTest do
  use ExUnit.Case
  doctest AppwriteElixir

  test "greets the world" do
    assert AppwriteElixir.hello() == :world
  end
end
