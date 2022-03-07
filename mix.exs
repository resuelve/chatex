defmodule Chatex.MixProject do
  use Mix.Project

  def project do
    [
      app:                :chatex,
      version:            "1.2.0",
      elixir:             "~> 1.6",
      start_permanent:    Mix.env() == :prod,
      deps:               deps(),
      test_coverage:      [tool: ExCoveralls],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo,          "~> 0.9.1", only: [:dev, :test]},
      {:excoveralls,    "~> 0.8", only: :test},
      {:goth,           "~> 0.9.0"},
      {:httpoison,      "~> 1.4"},
      {:mock,           "~> 0.3.0", only: :test},
      {:poison,         "~> 3.1"},
    ]
  end
end
