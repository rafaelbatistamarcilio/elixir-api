defmodule ElixirApi.Factory.UserFactory do
  alias ElixirApi.Model.User

  @doc "returns ElixirApi.Model.User"
  def build(id, name, birth, email) do
    %User{user_id: id, name: name, birth: birth, email: email}
  end

  def toMap(user) do
    Map.from_struct user
  end
end
