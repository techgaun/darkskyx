defmodule Darkskyx.Api do
  @moduledoc """
  Simple API wrapper for Darksky weather API
  """
  use HTTPoison.Base
  alias __MODULE__
  alias Darkskyx.Parser
  import Darkskyx.Utils

  @base_url "https://api.darksky.net/forecast"

  def forecast(lat, lng, opts) when is_number(lat) and is_number(lng) do
    
  end
  def forecast(lat, lng, opts \\ []) when is_bitstring(lat) and is_bitstring(lng) do
  end

  def build_url(path_arg, query_params) do
    "#{@base_url}/#{api_key}/#{path_arg}?#{URI.encode_query(query_params)}"
  end

  def read(path_arg, query_params) do
    path_arg
    |> build_url(query_params)
    |> Api.get(user_agent)
    |> Parser.parse
  end
end
