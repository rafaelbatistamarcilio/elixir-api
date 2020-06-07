defmodule ElixirApi.Validator.AddUserValidator do
  alias ElixirApi.Utils.AppExcetion

  @doc "user of ElixirApi.Model.User"
  def validate user do
    validateNilUser user
    validateName user.name
  end

  defp validateNilUser user do
    if is_nil user do
      raise %AppExcetion{message: "user can't be nil"}
    end
  end

  defp validateName name do
    if is_nil name do
      raise %AppExcetion{message: "user name can't be nil"}
    end
  end
end
