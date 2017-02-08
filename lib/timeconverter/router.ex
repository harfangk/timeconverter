defmodule Timeconverter.Router do
  use Plug.Router
  
  plug :match
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(Timeconverter.Router, [], port: get_port())
  end

  get "/" do
    conn = Plug.Conn.fetch_query_params(conn)
    result = inspect(Timeconverter.convert_datetime(conn.params))
    conn
    |> send_resp(200, result)
  end

  match _ do
    conn
    |> send_resp(404, "This is not the page you are looking for")
  end

  defp get_port() do
    port_env_variable = System.get_env("PORT")
    if is_nil(port_env_variable) do
      4000
    else
      String.to_integer(port_env_variable)
    end
  end
end
