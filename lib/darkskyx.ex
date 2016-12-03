defmodule Darkskyx do
  @moduledoc """
  Darkskyx is an Elixir SDK to talk with darksky.net API.

  For more details on API, refer to https://darksky.net/dev/docs

  ## Usage

      Darkskyx.forecast(41.032, -94.234)

      Darkskyx.forecast(41.043, -93.23432, %Darkskyx{lang: "ar"})

      Darkskyx.time_machine(41.043, -93.23432, 13432423)

      Darkskyx.time_machine(41.043, -93.23432, 13432423, %Darkskyx{lang: "ar", units: "si"})

      Darkskyx.current(37, -94)

      Darkskyx.current(37, -94, %Darkskyx{lang: "ar"})
  """

  defstruct extend: nil, exclude: nil, lang: "en", units: "auto"
  defdelegate forecast(lat, lng), to: Darkskyx.Api
  defdelegate forecast(lat, lng, params), to: Darkskyx.Api
  defdelegate time_machine(lat, lng, time), to: Darkskyx.Api
  defdelegate time_machine(lat, lng, time, params), to: Darkskyx.Api
  def current(lat, lng), do: lat |> forecast(lng) |> _format_current
  def current(lat, lng, params), do: lat |> forecast(lng, params) |> _format_current
  defp _format_current({:ok, %{"currently" => current}}), do: current
  defp _format_current(_), do: {:error, %{reason: "could not retrieve current weather"}}
end
