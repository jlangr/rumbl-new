defmodule Quizzy.Quiz do
  defstruct questions: [], name: "", seconds_per_question: 30

  def new(name), do:
    %Quizzy.Quiz{name: name}

  def add_question(quiz, question), do:
    Map.update(quiz, :questions, [], &(&1 ++ [question]))
end
