defmodule Chatex.MixProject do
  use Mix.Project

  def project do
    [
      app: :chatex,
      version: "3.3.0",
      elixir: "~> 1.14",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      source_url: "https://github.com/resuelve/chatex",
      docs: [
        main: "Chatex"
      ]
    ]
  end

  defp package do
    [
      organization: "resuelve",
      licenses: [],
      links: %{"GitHub" => "https://github.com/resuelve/chatex"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Chatex.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test]},
      {:excoveralls, "~> 0.18", only: :test},
      {:goth, "~> 1.4"},
      {:httpoison, "~> 2.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      ci: ["format --check-formatted"]
    ]
  end
end
