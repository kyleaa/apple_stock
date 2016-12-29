defmodule AppleStock do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(AppleStock.Repo, []),
      supervisor(AppleStock.Endpoint, []),
      worker(Cachex, [:alarm_cache, []])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppleStock.Supervisor]
    resp = Supervisor.start_link(children, opts)
    AppleStock.AlarmEngine.register_all_alarms
    resp
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AppleStock.Endpoint.config_change(changed, removed)
    :ok
  end
end
