defmodule Quizzy.Quiz do
  defstruct questions: []

  def new() do
    %Quizzy.Quiz{questions: []}
  end
end
