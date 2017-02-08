defmodule Timeconverter.Router do
  use Plug.Router
  
  plug :match
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(Timeconverter.Router, [])
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
end
