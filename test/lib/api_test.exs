defmodule Darkskyx.ApiTest do
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use ExUnit.Case, async: true
  alias Darkskyx.Api

  @time 1_514_764_800

  setup_all do
    HTTPoison.start()

    forecast_keys = [
      "currently",
      "daily",
      "flags",
      "hourly",
      "latitude",
      "longitude",
      "minutely",
      "offset",
      "timezone"
    ]

    time_machine_keys = [
      "currently",
      "flags",
      "hourly",
      "latitude",
      "longitude",
      "offset",
      "timezone"
    ]

    {:ok, forecast_keys: forecast_keys, time_machine_keys: time_machine_keys}
  end

  test "process_params returns parameters correctly" do
    assert %{lang: "en", units: "us"} = Api.process_params(nil)

    assert %{lang: "samar", units: "si", extend: "hourly"} =
             Api.process_params(%Darkskyx{lang: "samar", units: "si", extend: "hourly"})

    assert %{lang: "en"} = Api.process_params(%Darkskyx{})
  end

  describe "forecast/3" do
    test "no options", %{forecast_keys: forecast_keys} do
      use_cassette "valid_forecast" do
        {:ok, forecast} = Api.forecast(39.749476, -104.991428)

        forecast_keys
        |> Enum.each(fn key ->
          assert Enum.member?(Map.keys(forecast), key)
        end)
      end
    end

    test "with single exlude", %{forecast_keys: forecast_keys} do
      use_cassette "valid_forecast_without_daily" do
        {:ok, forecast} = Api.forecast(39.749476, -104.991428, %Darkskyx{exclude: "daily"})

        forecast_keys
        |> Enum.each(fn key ->
          case key do
            "daily" -> refute Enum.member?(Map.keys(forecast), key)
            _ -> assert Enum.member?(Map.keys(forecast), key)
          end
        end)
      end
    end

    test "with multiple exludes", %{forecast_keys: forecast_keys} do
      use_cassette "valid_forecast_without_daily_and_hourly" do
        {:ok, forecast} =
          Api.forecast(39.749476, -104.991428, %Darkskyx{exclude: "daily, hourly"})

        forecast_keys
        |> Enum.each(fn key ->
          case key do
            "daily" -> refute Enum.member?(Map.keys(forecast), key)
            "hourly" -> refute Enum.member?(Map.keys(forecast), key)
            _ -> assert Enum.member?(Map.keys(forecast), key)
          end
        end)
      end
    end
  end

  describe "time_machine/3" do
    test "no options", %{time_machine_keys: time_machine_keys} do
      use_cassette "valid_time_machine" do
        {:ok, time_machine} = Api.time_machine(39.749476, -104.991428, @time)

        time_machine_keys
        |> Enum.each(fn key ->
          assert Enum.member?(Map.keys(time_machine), key)
        end)
      end
    end

    test "with single exlude", %{time_machine_keys: time_machine_keys} do
      use_cassette "valid_time_machine_without_daily" do
        {:ok, time_machine} =
          Api.time_machine(39.749476, -104.991428, @time, %Darkskyx{exclude: "daily"})

        time_machine_keys
        |> Enum.each(fn key ->
          case key do
            "daily" -> refute Enum.member?(Map.keys(time_machine), key)
            _ -> assert Enum.member?(Map.keys(time_machine), key)
          end
        end)
      end
    end

    test "with multiple exludes", %{time_machine_keys: time_machine_keys} do
      use_cassette "valid_time_machine_without_daily_and_hourly" do
        {:ok, time_machine} =
          Api.time_machine(39.749476, -104.991428, @time, %Darkskyx{exclude: "daily, hourly"})

        time_machine_keys
        |> Enum.each(fn key ->
          case key do
            "hourly" -> refute Enum.member?(Map.keys(time_machine), key)
            "daily" -> refute Enum.member?(Map.keys(time_machine), key)
            _ -> assert Enum.member?(Map.keys(time_machine), key)
          end
        end)
      end
    end
  end
end
