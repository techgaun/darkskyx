defmodule Darkskyx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :darkskyx,
      version: "0.1.5",
      elixir: "~> 1.2",
      description: "A Darksky.net weather api client for Elixir",
      source_url: "https://github.com/techgaun/darkskyx",
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: [extras: ["README.md"]],
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.2"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:dogma, "~> 0.1", only: [:dev, :test]},
      {:exvcr, "~> 0.10", only: :test}
    ]
  end

  defp package do
    [
      maintainers: [
        "Samar Acharya"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/techgaun/darkskyx"}
    ]
  end
end
