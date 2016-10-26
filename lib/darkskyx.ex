defmodule Darkskyx do
  @moduledoc """
  Darkskyx is an Elixir SDK to talk with darksky.net API.

  For more details on API, refer to https://darksky.net/dev/docs

  ## Usage

      Darkskyx.forecast(41.032, -94.234)

      Darkskyx.forecast(41.043, -93.23432, %Darkskyx{lang: "ar"})

      Darkskyx.time_machine(41.043, -93.23432, 13432423)

      Darkskyx.time_machine(41.043, -93.23432, 13432423, %Darkskyx{lang: "ar", units: "si"})
  """

  defstruct extend: nil, exclude: nil, lang: "en", units: "auto"
  defdelegate forecast(lat, lng), to: Darkskyx.Api
  defdelegate forecast(lat, lng, params), to: Darkskyx.Api
  defdelegate time_machine(lat, lng, time), to: Darkskyx.Api
  defdelegate time_machine(lat, lng, time, params), to: Darkskyx.Api
end
