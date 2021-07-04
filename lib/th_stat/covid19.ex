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
  def get_today_cases() do
    case get("/json/covid19v2/getTodayCases.json") do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok,
         %{
           confirmed: body["Confirmed"],
           deaths: body["Deaths"],
           dev_by: body["DevBy"],
           hospitalized: body["Hospitalized"],
           new_confirmed: body["NewConfirmed"],
           new_death: body["NewDeaths"],
           new_hospitalized: body["NewHospitalized"],
           new_recovered: body["NewRecovered"],
           recovered: body["Recovered"],
           update_date: parse_update_date!(body["UpdateDate"])
         }}

      {:ok, %Tesla.Env{body: body}} ->
        {:error, body}
    end
  end

  @doc """
  Summarize covid-19 cases by date.
  """
  def get_timeline() do
    case get("/json/covid19v2/getTimeline.json") do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok,
         %{
           dev_by: body["DevBy"],
           update_date: parse_update_date!(body["UpdateDate"]),
           data:
             Enum.map(body["Data"], fn entry ->
               %{
                 date: Timex.parse!(entry["Date"], "{0M}/{D}/{YYYY}") |> Timex.to_date(),
                 new_confirmed: entry["NewConfirmed"],
                 new_recovered: entry["NewRecovered"],
                 new_hospitalized: entry["NewHospitalized"],
                 new_deaths: entry["NewDeaths"],
                 confirmed: entry["Confirmed"],
                 recovered: entry["Recovered"],
                 hospitalized: entry["Hospitalized"],
                 deaths: entry["Deaths"]
               }
             end)
         }}

      {:ok, %Tesla.Env{body: body}} ->
        {:error, body}
    end
  end

  defp parse_update_date!(update_date) do
    update_date
    |> Timex.parse!("{D}/{0M}/{YYYY} {h24}:{m}")
    |> Timex.to_datetime("Asia/Bangkok")
  end
end
