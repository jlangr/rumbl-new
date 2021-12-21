defmodule Quizzy.Question do
  defstruct text: "", answers: [], answer: nil

  def new(text), do:
    %Quizzy.Question{text: text}

  def add_answer(question, answer, is_correct? \\ false), do:
    Map.update(question, :answers, [],
      &(&1 ++ [%{ text: answer, correct: is_correct? }]))
    |> reindex

  def add_correct_answer(question, answer), do:
    add_answer(question, answer, true)
    |> reindex

  def add_answers(question, answer_texts), do:
    Enum.reduce(answer_texts, question, fn answer_text, question ->
      add_answer(question, answer_text) end)
    |> reindex

  defp indexed_answers(question), do:
    Enum.with_index(question.answers,
      fn element, index -> Map.put(element, :index, index) end)

  def set_correct_answer(question, index) do
    Enum.map(question.answers,
      fn answer -> Map.put(answer, :correct, index == answer.index) end)
    |> replace_answers(question)
  end

  def move(question, from_index, to_index) do
    answer = Enum.at(question.answers, from_index)
    Enum.to_list(question.answers)
    |> List.delete(answer)
    |> List.insert_at(
         (if from_index < to_index, do: to_index - 1, else: to_index),
         answer)
    |> replace_answers(question)
    |> reindex
  end

  defp replace_answers(answers, question), do:
    Map.put(question, :answers, answers)

  defp reindex(question), do:
    replace_answers(indexed_answers(question), question)
end
