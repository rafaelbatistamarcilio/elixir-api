defmodule ElixirApi.Repository.User do
  import Ecto.Query

  alias ElixirApi.Model.User
  alias ElixirApi.Database.Manager
  alias ElixirApi.Repository.Specification.User, as: UserSpecification

  # @behaviour BaseRepository

  # @impl BaseRepository
  def find do
    query = from user in User
    Manager.all query
  end

  def findById id do
    query = from user in User, where: user.user_id == ^id
    Manager.one query
  end

  def search filter do
    query = from user in User, where: 1==1
    query = UserSpecification.build(query, filter)
    Manager.all query
  end

  def save user do
    Manager.insert!(user)
  end

  def update user do
    Manager.update!(user)
  end

  def delete id do
    Manager.delete! id
  end
end
