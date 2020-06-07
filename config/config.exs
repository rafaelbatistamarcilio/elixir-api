import Config

config :elixir_api, :port, System.get_env("PORT")

config :elixir_api, ElixirApi.Database.Manager,
  database: "elixir_app",
  host: "localhost",
  port: 3306,
  username: "elixir_app",
  password: "elixir_app"

config :elixir_api, ecto_repos: [ElixirApi.Database.Manager]

# import_config "#{Mix.env()}.exs"
