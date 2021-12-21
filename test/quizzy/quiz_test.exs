defmodule Quizzy.QuizTest do
  use ExUnit.Case
  import Quizzy.Quiz

  test "has no questions by default" do
    quiz = new()

    assert length(quiz.questions) == 0
  end

#  test "can add"
end
