defmodule ThStat.Covid19.MixProject do
  use Mix.Project

  def project do
    [
      app: :th_stat_covid19,
      version: "0.1.0",
      elixir: "~> 1.12-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:jason, "~> 1.2"},
      {:finch, "~> 0.5"}
    ]
  end
end