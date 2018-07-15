defmodule Darkskyx.ApiTest do
  use ExUnit.Case, async: true
  alias Darkskyx.Api

  test "process_params returns parameters correctly" do
    assert %{lang: "en", units: "us"} = Api.process_params(nil)

    assert %{lang: "samar", units: "si", extend: "hourly"} =
             Api.process_params(%Darkskyx{lang: "samar", units: "si", extend: "hourly"})

    assert %{lang: "en"} = Api.process_params(%Darkskyx{})
  end
end
