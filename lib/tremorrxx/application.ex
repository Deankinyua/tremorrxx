defmodule Tremorrxx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TremorrxxWeb.Telemetry,
      Tremorrxx.Repo,
      {DNSCluster, query: Application.get_env(:tremorrxx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Tremorrxx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Tremorrxx.Finch},
      # Start a worker by calling: Tremorrxx.Worker.start_link(arg)
      # {Tremorrxx.Worker, arg},
      # Start to serve requests, typically the last entry
      TremorrxxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tremorrxx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TremorrxxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
