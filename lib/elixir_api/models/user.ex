defmodule ElixirApi.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  def changeset(user, params) do
    cast(user, params, [:name, :birth, :email])
  end

  @derive {Jason.Encoder, only: [:user_id, :name, :birth, :email]}
  @primary_key { :user_id, :integer, autogenerate: false}
  schema "users" do
    field :name, :string
    field :birth, :string
    field :email, :string
  end

end
