defmodule Darkskyx.Api do
  @moduledoc """
  Simple API wrapper for Darksky weather API
  """
  use HTTPoison.Base
  alias __MODULE__
  alias Darkskyx.Parser
  import Darkskyx.Utils

  @base_url "https://api.darksky.net/forecast"

  def forecast(lat, lng), do: read("#{lat},#{lng}", process_params(nil))
  def forecast(lat, lng, params) do
    params = params
      |> process_params
    read("#{lat},#{lng}", params)
  end

  def build_url(path_arg, query_params) do
    "#{@base_url}/#{api_key}/#{path_arg}?#{URI.encode_query(query_params)}"
  end

  def read(path_arg, query_params \\ %{}) do
    path_arg
    |> build_url(query_params)
    |> Api.get(request_headers)
    |> Parser.parse
  end

  def process_params(nil), do: defaults
  def process_params(params) do
    defaults
    |> Map.merge(params)
    |> Map.from_struct
  end
end
