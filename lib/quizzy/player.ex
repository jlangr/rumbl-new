defmodule Quizzy.Player do
  defstruct name: ""

  def new(name), do:
    %Quizzy.Player{name: name}

end
