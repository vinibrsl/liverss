defmodule LiveRSS.MixProject do
  use Mix.Project

  def project do
    [
      app: :liverss,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:inets, :ssl],
      extra_applications: [:logger, :feeder_ex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:feeder_ex, "~> 1.1"}
    ]
  end
end
