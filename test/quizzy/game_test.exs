defmodule Quizzy.GameTest do
  use ExUnit.Case
  import Quizzy.Game
  alias Quizzy.Player
  alias Quizzy.Question
  alias Quizzy.Quiz

  setup do
    quiz = Quiz.new("test quiz")
    question1 = Question.new("What?")
    question2 = Question.new("Why?")
    player1 = Player.new("Joe")
    player2 = Player.new("Jane")

    {:ok,
      game: new(quiz),
      quiz: quiz,
      player1: player1, player2: player2,
      question1: question1, question2: question2
    }
  end

  test "initializes game", %{ game: game, quiz: quiz } do
    assert game.quiz == quiz
  end

  test "can add players", context do
    game = context.game
           |> add_player(context.player1)
           |> add_player(context.player2)

    assert game.players == [context.player2, context.player1]
  end

  # duplicate player name

  def add_two_players(game, %{ player1: player1, player2: player2}), do:
    game |> add_player(player1) |> add_player(player2)

  def add_two_questions(quiz, %{ question1: question1, question2: question2}), do:
    quiz |> Quiz.add_question(question1) |> Quiz.add_question(question2)

  test "next question", context do
    quiz = context.quiz |> add_two_questions(context)
    game = new(quiz) |> add_two_players(context)

    game = next_question(game)
    assert game.current_question == context.question1
    game = next_question(game)
    assert game.current_question == context.question2
  end


  # is playable -- at least one question
  # and all questsions are playable
  # can start -- at least one player
end
