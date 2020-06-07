defmodule ElixirApi.Repository.Specification.User do
  import Ecto.Query

  def filterByName(query, filter) do
    unless is_nil Map.get(filter, :name) do
      from(user in query, where: user.name == ^filter.name)
    else
      query
    end
  end

  def filterByEmail(query, filter) do
    unless is_nil Map.get(filter, :email) do
      from(user in query, where: user.email == ^filter.email)
    else
      query
    end
  end

  def filterByBirth(query, filter) do
    unless is_nil Map.get(filter, :birth) do
      from(user in query, where: user.birth == ^filter.birth)
    else
      query
    end
  end

  def build(query, filter) do
    query = filterByName(query, filter)
    query = filterByEmail(query, filter)
    query = filterByBirth(query, filter)
    query
  end
end
