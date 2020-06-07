defmodule ElixirApi.Factory.ErrorResponse do
  @doc "reason is the error reason"
  def build(reason) do
    Jason.encode!(%{message: reason.message})
  end
end
