defmodule Quizzy.QuizTest do
  use ExUnit.Case
  alias Quizzy.Question
  import Quizzy.Quiz

  setup do
    { :ok, quiz: new("x") }
  end

  test "has no questions by default", %{quiz: quiz} do
    assert length(quiz.questions) == 0
  end

  test "can add a question", %{quiz: quiz} do
    question = Question.new("what")

    quiz = add_question(quiz, question)

    assert quiz.questions == [question]
  end
end
