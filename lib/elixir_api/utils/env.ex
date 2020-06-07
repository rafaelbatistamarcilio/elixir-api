defmodule ElixirApi.Utils.Env do
  def port do
    p = Application.fetch_env!(:elixir_api, :port)
    if is_nil p do
      8080
    else
      {value, _} = Integer.parse(Application.fetch_env!(:elixir_api, :port))
      value
    end
  end

  def getInteger(prop) do
    envProp = Application.fetch_env!(:elixir_api, prop)

    if is_nil envProp do
      nil
    else
      {value, _} = Integer.parse(envProp)
      value
    end
  end

  def get(prop) do
    Application.fetch_env!(:elixir_api, prop)
  end
end
