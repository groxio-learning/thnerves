defmodule Clock.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Clock.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: Clock.Worker.start_link(arg)
        # {Clock.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [{Clock.Server, Application.get_all_env(:clock)}]
  end

  def children(_target) do
    [{Clock.Server, Application.get_all_env(:clock)}]
  end

  def target() do
    Application.get_env(:clock, :target)
  end
end
