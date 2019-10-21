defmodule Darkskyx.Api do
  @moduledoc """
  Simple API wrapper for Darksky weather API
  """
  alias Darkskyx.Parser
  import Darkskyx.Utils

  @base_url "https://api.darksky.net/forecast"

  @doc """
  Perform a forecast API call for given latitude longitude
  """
  def forecast(lat, lng, params \\ defaults()), do: read("#{lat},#{lng}", params)

  @doc """
  Perform a time machine API call for given latitude, longitude and time

  ## time
  Either be a UNIX time (that is, seconds since midnight GMT on 1 Jan 1970)
  or a string formatted as follows: `[YYYY]-[MM]-[DD]T[HH]:[MM]:[SS][timezone]`.
  timezone should either be omitted (to refer to local time for the location being requested),
  Z (referring to GMT time), or +[HH][MM] or -[HH][MM] for an offset from GMT in hours and minutes.
  The timezone is only used for determining the time of the request; the response will always be relative to the local time zone.
  """
  def time_machine(lat, lng, time, params \\ defaults()),
    do: read("#{lat},#{lng},#{time}", params)

  def read(path_arg, query_params \\ %{}) do
    path_arg
    |> build_url(query_params)
    |> HTTPoison.get(request_headers())
    |> Parser.parse()
  end

  defp build_url(path_arg, query_params) do
    query_params = process_params(query_params)

    "#{@base_url}/#{api_key()}/#{path_arg}?#{URI.encode_query(query_params)}"
  end

  @doc false
  def process_params(nil), do: defaults()
  def process_params(params) do
    defaults()
    |> Map.merge(params)
    |> Map.delete(:__struct__)
  end
end
