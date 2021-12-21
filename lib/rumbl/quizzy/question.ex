defmodule Quizzy.Question do
  defstruct text: "", answers: [], answer: nil

  def new(text), do:
    %Quizzy.Question{text: text}

  def add_answer(question, answer, is_correct? \\ false), do:
    Map.update(question, :answers, [],
      &(&1 ++ [%{ text: answer, correct: is_correct? }]))
    |> reindex

  def add_correct_answer(question, answer), do:
    add_answer(question, answer, true) |> reindex

  def add_answers(question, answer_texts), do:
    Enum.reduce(answer_texts, question, fn answer_text, question ->
      add_answer(question, answer_text)
    end) |> reindex

  defp indexed_answers(question), do:
    Enum.with_index(question.answers, fn element, index ->
      Map.put(element, :index, index)
    end)

  defp reindex(question), do:
    replace_answers(question, indexed_answers(question))

  def set_correct_answer(question, index) do
    answers = Enum.map(question.answers, &(Map.put(&1, :correct, false)))
    |> Enum.map(fn answer ->
      case answer, do:
        (%{index: ^index} -> Map.put(answer, :correct, true)
        _ -> answer)
    end)
    replace_answers(question, answers)
  end

  defp replace_answers(question, answers), do:
    Map.put(question, :answers, answers)

  def move(question, from_index, to_index) do
    answer = Enum.at(question.answers, from_index)
    answers = Enum.to_list(question.answers)
      |> List.delete(answer)
      |> List.insert_at(
            (if from_index < to_index, do: to_index - 1, else: to_index),
            answer)
    replace_answers(question, answers) |> reindex
  end
end
