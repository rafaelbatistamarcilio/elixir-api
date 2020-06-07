defmodule ElixirApi.Application do
  @moduledoc false

  use Application
  require Logger

  alias ElixirApi.Utils.Env
  # alias ElixirApi.Database.Manager


  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: ElixirApi.Router,
        options: [
          port: Env.port,
          compress: true
        ]
      },
      ElixirApi.Database.Manager
    ]

    opts = [strategy: :one_for_one, name: ElixirApi.Supervisor]

    Logger.info("Starting application at port: #{Env.port}")

    Supervisor.start_link(children, opts)
  end
end
