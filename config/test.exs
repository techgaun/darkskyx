use Mix.Config

config :darkskyx,
  api_key: System.get_env("DARKSKY_API_KEY"),
  defaults: [
    units: "us",
    lang: "en"
  ]

config :exvcr,
  vcr_cassette_library_dir: "test/fixture/vcr_cassettes",
  filter_sensitive_data: [
    [pattern: System.get_env("DARKSKY_API_KEY"), placeholder: "DARKSKY_API_KEY"]
  ]
