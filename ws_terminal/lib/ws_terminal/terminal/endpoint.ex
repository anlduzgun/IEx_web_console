defmodule WsTerminal.Terminal.Endpoint do
  use Plug.Router
  
  plug :match
  plug :dispatch

   match _ do
    send_resp(conn, 404, "not found")
  end
  
end
