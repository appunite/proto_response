defmodule ProtoResponse.Mixfile do
  use Mix.Project

  def project do
    [
      app: :proto_response,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env)
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:exprotobuf, "~> 1.0", only: :test},
      {:phoenix,    "~> 1.1", only: :test}
    ]
  end
end
