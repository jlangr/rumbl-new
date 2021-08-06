defmodule Rumbl.Accounts do 
  alias Rumbl.Accounts.User
  alias Rumbl.Repo

  def list_users, do:
    Repo.all(User)

  def get_user(id), do:
    Repo.get(User, id)

  def get_user!(id), do:
    Repo.get!(User, id)
  
  def get_user_by(params), do:
    Repo.get_by(User, params)
end
