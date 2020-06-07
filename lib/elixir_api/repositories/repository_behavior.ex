defmodule ElixirApi.Repository.BaseRepository do

  alias ElixirApi.Repository.User

  @callback find() :: [User.t] | {:error, String.t()}

  # @callback findById(integer) :: [String.t()]
end
