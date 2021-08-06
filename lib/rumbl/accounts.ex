defmodule Rumbl.Accounts do 
  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users, do:
    Repo.all(User)

  def get_user(id), do:
    Repo.get(User, id)

  def get_user!(id), do:
    Repo.get!(User, id)
  
  def get_user_by(params), do:
    Repo.get_by(User, params)

  # book q: why define this first before it's seemingly needed?
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
