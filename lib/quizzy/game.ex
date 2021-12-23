defmodule Quizzy.Game do
  defstruct quiz: nil, players: [], remaining_questions: [], current_question: nil

  def new(quiz), do:
    %Quizzy.Game{quiz: quiz, remaining_questions: quiz.questions}

  def add_player(game, player), do:
    Map.update(game, :players, [], &([player | &1]))

  def next_question(game) do
    [next_question | remaining_questions] = game.remaining_questions
    game
    |> Map.put(:current_question, Map.put(next_question, :state, :ready_to_play))
    |> Map.put(:remaining_questions, remaining_questions)
  end

  def start_question(game) do
    put_in(game.current_question.state, :playing)
  end
end
