defmodule Darkskyx.ParserTest do
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use ExUnit.Case, async: true
  alias Darkskyx.Api

  describe "parse/1" do
    test "parse response with 200" do
      use_cassette "valid_forecast" do
        {:ok, forecast, headers} = Api.forecast(39.749476, -104.991428)
        assert is_map(forecast)
        assert is_map(headers)
      end
    end
    test "parse response with 400" do
      use_cassette "invalid_400" do
        {:error, body, status} = Api.forecast(39.749476, 1234)
        assert body["error"] == "The given location is invalid."
        assert status == 400
      end
    end
    test "parse response with 403" do
      use_cassette "invalid_403" do
        {:error, body, status} = Api.forecast(39.749476, -104.991428)
        assert body["error"] == "permission denied"
        assert status == 403
      end
    end
  end
end
