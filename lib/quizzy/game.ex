defmodule Quizzy.Game do
  defstruct quiz: nil

  def new(quiz), do:
    %Quizzy.Game{quiz: quiz}
end
