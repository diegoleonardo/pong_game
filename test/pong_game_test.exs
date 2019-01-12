defmodule PongGameTest do
  use ExUnit.Case
  doctest PongGame

  test "greets the world" do
    assert PongGame.hello() == :world
  end
end
