defmodule Darkskyx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :darkskyx,
      version: "1.0.0",
      elixir: "~> 1.5",
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
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.2"},
      {:ex_doc, "~> 0.21", only: :dev},
      {:exvcr, "~> 0.10", only: :test},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false}
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
