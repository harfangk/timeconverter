defmodule Timeconverter.Router do
  use Plug.Router
  
  plug :match
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(Timeconverter.Router, [])
  end

  get "/" do
    conn
    |> send_resp(200, "wow!")
  end

  match _ do
    conn
    |> send_resp(200, "woooow!")
  end
end
