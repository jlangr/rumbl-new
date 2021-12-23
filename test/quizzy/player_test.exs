defmodule Quizzy.PlayerTest do
  use ExUnit.Case

  import Quizzy.Player

  setup do
    {:ok, player: new("Joe")}
  end

  test "initializes player name", %{ player: player } do
    assert player.name == "Joe"
  end
end
