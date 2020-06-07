defmodule ElixirApiTest do
  use ExUnit.Case
  doctest ElixirApi

  test "greets the world" do
    assert ElixirApi.hello() == :world
  end
end
