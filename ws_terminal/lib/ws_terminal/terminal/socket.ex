defmodule WsTerminal.Terminal.Socket do

  @behaviour :cowboy_websocket


  @impl true 
  def init(req, state) do 
    opts = %{idle_timeout: 90000}
    {:cowboy_websocket, req, state, opts}
  end

  @impl true 
  def websocket_init(_) do
    {:ok, tty} = ExTTY.start_link([handler: self()])
    {[], %{tty: tty}}
  end

 
  @impl true
  def websocket_handle(frame, state)


  def websocket_handle(:ping, state), do: {[:pong], state}

 
  def websocket_handle({:text, message}, state) do
    ExTTY.send_text(state.tty, message)
    {[], state}
  end


  @impl true 
  def websocket_info(info, state)

  def websocket_info({:tty_data, data}, state) do
    {[{:text, data}], state}
  end
end
