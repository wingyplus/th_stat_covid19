defmodule ThStat.Covid19.Supervisor do
  use Supervisor

  def start_link(_args), do: Supervisor.start_link(__MODULE__, strategy: :one_for_one)

  @impl true
  def init(_args) do
    children = [
      {Finch, name: ThStat.Covid19.Finch}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
