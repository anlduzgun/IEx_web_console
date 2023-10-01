defmodule WsTerminal.Application do
 
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: WsTerminal, options: [port: 4001, dispatch: dispatch()]}
      
    ]

    opts = [strategy: :one_for_one, name: WsTerminal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
         #change "/path/to/your/dir/" to your exact path of your project's directory
        [
          {"/console", :cowboy_static, {:file, "/path/to/your/dir/ws_terminal/frontend/index.html"}},
          {"/node_modules/[...]" , :cowboy_static, {:dir,  "/path/to/your/dir/ws_terminal/frontend/node_modules"}},
          {"/app.js", :cowboy_static, {:file, "/path/to/your/dir/ws_terminal/ws_terminal/frontend/app.js"}},
          {"/socket",WsTerminal.Terminal.Socket, []},
          {:_, Plug.Cowboy.Handler, {WsTerminal.Terminal.Endpoint, []}}
        ]}
    ]
  end
end
