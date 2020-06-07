defmodule ElixirApi.Controller.UserController do
  use Plug.Router
  use Plug.ErrorHandler

  alias ElixirApi.Factory.UserFactory
  alias ElixirApi.Repository.User, as: UserRepository
  alias ElixirApi.Factory.ErrorResponse
  alias ElixirApi.Validator.AddUserValidator
  alias ElixirApi.Utils.AppExcetion
  alias ElixirApi.Model.User

  plug Plug.Parsers, parsers: [:json], pass:  ["application/json"], json_decoder: Jason
  plug :match
  plug :dispatch

  get "/" do
    user = UserRepository.find()
    send_resp(conn, 200, Jason.encode! user)
  end

  get "/search" do
    filter = conn.query_params |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    users = UserRepository.search(filter)
    send_resp(conn, 200, Jason.encode! users)
  end

  # path params conn.params["id"] ou simplesmente acessar a variave id, veja em #{id}
  get "/:id" do
    user = UserRepository.findById(id)
    send_resp(conn, 200, Jason.encode! user)
  end

  post "/" do
    user = UserFactory.build(nil, conn.body_params["name"], conn.body_params["birth"], conn.body_params["email"])
    AddUserValidator.validate(user)
    response = UserRepository.save(user)
    send_resp(conn, 200, Jason.encode! response )
  end

  put "/:id" do
    user = UserFactory.build(nil, conn.body_params["name"], conn.body_params["birth"], conn.body_params["email"])
    oldUser = UserRepository.findById(id)

    unless is_nil oldUser do
      changeset = User.changeset(oldUser, UserFactory.toMap user);
      user = UserRepository.update(changeset)
      send_resp(conn, 200, Jason.encode! user)
    else
      raise %AppExcetion{message: "User id #{id} not found"}
    end
  end

  delete "/:id" do
    user = UserRepository.findById(id)
    unless is_nil user do
      UserRepository.delete(user)
      send_resp(conn, 200, Jason.encode!(%{message: "deleted"}))
    else
      raise %AppExcetion{message: "User id #{id} not found"}
    end
  end

  match _ do
    send_resp(conn, 404, "NOT FOUND!!")
  end

  def handle_errors(conn, %{ reason: reason, stack: stack}) do
      IO.inspect(stack, label: :stack)
      send_resp(conn, conn.status, ErrorResponse.build(reason))
  end
end
