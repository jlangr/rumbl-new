defmodule Rumbl.QuizTest do
  use ExUnit.Case

  alias Rumbl.Quiz

  @moduletag :capture_log

  doctest Quiz

  test "module exists" do
    assert is_list(Quiz.module_info())
  end
end
