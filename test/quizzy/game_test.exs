defmodule Quizzy.GameTest do
  use ExUnit.Case
  import Quizzy.Game

  setup do
    quiz = Quizzy.Quiz.new("test quiz")
    {:ok, game: new(quiz), quiz: quiz }
  end

  test "initializes game", %{ game: game, quiz: quiz } do
    assert game.quiz == quiz
  end
end
