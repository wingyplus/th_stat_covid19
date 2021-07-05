# ThStat.Covid19

HTTP client for covid19.th-stat.com open api plus some extras:

* Change field name to conform Elixir convention (snake case).
* Convert date time to `Date.t()` or `DateTime.t()`. You don't need to worry about
  date time string inconsistent.

## Installation

```elixir
def deps do
  [
    {:th_stat_covid19, "~> 0.1.0"}
  ]
end
```

## Usage

First, you need to add `ThStat.Covid19.Supervisor` to your application.

```elixir
children = [
  ...,
  ThStat.Covid19.Supervisor
]

Supervisor.start_link(children, strategy: your_strategy)
```

After that, use it!!

```elixir
iex> {:ok, %{data: timeline}} = ThStat.Covid19.get_timeline()
iex> timeline
%{
...
}
```

