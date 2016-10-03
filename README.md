# Darkskyx

[![Build Status](https://semaphoreci.com/api/v1/samaracharya/darkskyx/branches/master/badge.svg)](https://semaphoreci.com/samaracharya/darkskyx)

> A Darksky.com weather api client for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

Add `darkskyx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:darkskyx, "~> 0.1.1"}]
end
```

Ensure `darkskyx` is started before your application:

```elixir
def application do
  [applications: [:darkskyx]]
end
```

## Usage

You can use darkskyx to perform forecast as well as time machine request. You will need to configure the darksky api key properly.

### configuration

The simplest would be to set darksky api key as below:

```shell
export DARKSKY_API_KEY=<api_key>
```

Now, in your config.exs (or environment specific configuration), add the config block to configure Darkskyx. You can pass keyword list of `units`, `lang`, `excludes` and `extends` for the `defaults` config block which will be used to override the global default configuration. The default configuration is to use `units: auto` and `lang: en`. On top of the default configuration, you can also override the default configuration per request by passing the `%Darkskyx{}` struct configured to your liking.

```elixir
config :darkskyx, api_key: System.get_env("DARKSKY_API_KEY"),
  defaults: [
    units: "us",
    lang: "en"
  ]
```

### Examples

```elixir
Darkskyx.forecast(41.032, -94.234)

Darkskyx.forecast(41.043, -93.23432, %Darkskyx{lang: "ar"})

Darkskyx.forecast(41.032, -94.234, %Darkskyx{exclude: "daily,hourly"})

Darkskyx.time_machine(41.043, -93.23432, 13432423)

Darkskyx.time_machine(41.043, -93.23432, 13432423, %Darkskyx{lang: "ar", units: "si"})
```

## To Do

- Consider adding shortcuts such as current instead of having to parse response on users side
- Consider adding rate-limit and show current day API usage

## Author

- [Samar Acharya](https://github.com/techgaun)

## License

- See [License](LICENSE) for more details.
