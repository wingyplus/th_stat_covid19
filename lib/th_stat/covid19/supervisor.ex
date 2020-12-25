defmodule ThStat.Covid19.Supervisor do
  use Supervisor

  def start_link(args), do: Supervisor.start_link(__MODULE__, args, name: __MODULE__)

  @impl true
  def init(_args) do
    children = [
      {Finch, name: ThStat.Covid19.Finch}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
