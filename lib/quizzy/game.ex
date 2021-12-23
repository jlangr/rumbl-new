defmodule Quizzy.Game do
  defstruct quiz: nil, players: [], remaining_questions: [], current_question: nil

  def new(quiz), do:
    %Quizzy.Game{quiz: quiz, remaining_questions: quiz.questions}

  def add_player(game, player) do
    Map.update(game, :players, [], &([player | &1]))
  end

  def next_question(game) do
    [next_question | remaining_questions] = game.remaining_questions
    game
    |> Map.put(:current_question, next_question)
    |> Map.put(:remaining_questions, remaining_questions)
  end
end
