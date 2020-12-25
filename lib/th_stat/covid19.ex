defmodule ThStat.Covid19 do
  @moduledoc """
  HTTP client for covid19.th-stat.com open api.
  """
  use Tesla

  adapter Tesla.Adapter.Finch, name: ThStat.Covid19.Finch

  plug Tesla.Middleware.BaseUrl, "https://covid19.th-stat.com"
  plug Tesla.Middleware.Headers, [{"content-type", "application/json"}]
  plug Tesla.Middleware.JSON

  @doc """
  Covid19 stats for today.
  """
  def today() do
    get("/api/open/today")
  end

  @doc """
  Covid19 stats for each day.
  """
  def timeline() do
    get("/api/open/timeline")
  end

  @doc """
  Covid19 case in details.
  """
  def cases() do
    get("/api/open/cases")
  end

  @doc """
  Covid19 case sumarize in each province.
  """
  def cases_sum() do
    get("/api/open/cases/sum")
  end
end
