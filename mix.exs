defmodule ProtoResponse.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :proto_response,
      deps: deps(),
      description: description(),
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package(),
      version: @version
    ]
  end

  defp package do
    [
      name: :proto_response,
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Tobiasz Małecki"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/amatalai/proto_response"}
    ]
  end

  defp description do
    "Asserts the given status code, that we have an application/x-protobuf response and returns the decoded Protobuf."
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
