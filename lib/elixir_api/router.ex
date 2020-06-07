defmodule ElixirApi.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias ElixirApi.Factory.ErrorResponse
  alias ElixirApi.Controller.UserController

  plug :match
  plug Plug.Parsers, parsers: [:json], pass:  ["application/json"], json_decoder: Jason
  plug :dispatch

  forward "/api/user", to: UserController

  match _ do
    send_resp(conn, 404, "NOT FOUND!")
  end

  def handle_errors(conn, %{ reason: reason, stack: stack}) do
      IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, ErrorResponse.build(reason))
  end
end
