defmodule Rumbl.QuestionTest do
  use ExUnit.Case
  import Rumbl.Question

  test "create from question text" do
    question = new("Why?")

    assert question.text == "Why?"
    assert length(question.answers) == 0
  end

  test "answers indexed and returned in order added" do
    question = new("Why?")
               |> add_answer("Alpha")
               |> add_answer("Beta")
               |> add_answer("Gamma")

    assert question.answers == [
             %{text: "Alpha", correct: false, index: 0},
             %{text: "Beta", correct: false, index: 1},
             %{text: "Gamma", correct: false, index: 2}
           ]
  end

  test "adds correct answer" do
    question = new("Why?")

               |> add_correct_answer("Because")

    assert question.answers == [%{text: "Because", correct: true, index: 0}]
  end

  test "adds multiple answers" do
    question = new("Why?")

               |> add_answers(["Because", "Dunno"])

    assert question.answers == [
             %{text: "Because", correct: false, index: 0},
             %{text: "Dunno", correct: false, index: 1}
           ]
  end

  test "sets correct answer when none set" do
    question = new("Why?")
               |> add_answers(["Because", "Dunno"])

               |> set_correct_answer(0)

    assert question.answers == [
             %{text: "Because", correct: true, index: 0},
             %{text: "Dunno", correct: false, index: 1}
           ]
  end

  # ? nest tests

  test "updates correct answer when set" do
    question = new("Why?")
               |> add_answers(["A", "B", "C"])
               |> set_correct_answer(2)

               |> set_correct_answer(0)

    assert question.answers == [
             %{text: "A", correct: true, index: 0},
             %{text: "B", correct: false, index: 1},
             %{text: "C", correct: false, index: 2}
           ]
  end

  describe "reorder" do
    test "reorders to earlier position" do
      question = new("Why?")
                 |> add_answers(["A", "B", "C", "D"])

                 |> move(3, 0)

      assert question.answers == [
               %{text: "D", correct: false, index: 0},
               %{text: "A", correct: false, index: 1},
               %{text: "B", correct: false, index: 2},
               %{text: "C", correct: false, index: 3}
             ]
    end

    test "reorders to later position" do
      question = new("Why?")
                 |> add_answers(["A", "B", "C", "D"])

                 |> move(0, 3)

      assert question.answers == [
               %{text: "B", correct: false, index: 0},
               %{text: "C", correct: false, index: 1},
               %{text: "A", correct: false, index: 2},
               %{text: "D", correct: false, index: 3}
             ]
    end

    test "reorders to after last position" do
      question = new("Why?")
                 |> add_answers(["A", "B", "C", "D"])

                 |> move(0, 4)

      assert question.answers == [
               %{text: "B", correct: false, index: 0},
               %{text: "C", correct: false, index: 1},
               %{text: "D", correct: false, index: 2},
               %{text: "A", correct: false, index: 3},
             ]
    end
  end
end
