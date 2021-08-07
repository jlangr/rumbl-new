field :password, :string, virtual: true
field :password_hash, :string

def registration_changeset(user, params) do
  user
  |> changeset(params)
  |> cast(params, [:password])
  |> validate_required([:password])
  |> validate_length(:password, min: 6, max: 100)
  |> put_pass_hash()
end

def put_pass_hash(changeset) do
  case changeset do
    %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
      put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
    _ ->
      changeset
  end
end
