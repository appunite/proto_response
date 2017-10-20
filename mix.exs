defmodule ProtoResponse.Mixfile do
  use Mix.Project

  @version "0.4.0"

  def project do
    [
      app: :proto_response,
      deps: deps(System.get_env("PROTOBUF_PACKAGE")),
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
      links: %{"GitHub" => "https://github.com/appunite/proto_response"}
    ]
  end

  defp description do
    "Provides helper function similar to Phoenix.ConnTest.json_response/2, but for protobuf"
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/proto.ex"]
  defp elixirc_paths(_),     do: ["lib"]

  # both libraries uses same module name :/
  defp deps("exprotobuf") do
    [
      {:exprotobuf, "~> 1.0", optional: true},
      {:phoenix, "~> 1.1"}
    ]
  end
  defp deps("protobuf") do
    [
      {:protobuf, "~> 0.3.2", optional: true},
      {:phoenix, "~> 1.1"}
    ]
  end
  defp deps(_) do
    [
      {:exprotobuf, "~> 1.0", optional: true},
      {:protobuf, "~> 0.3.2", optional: true},
      {:phoenix, "~> 1.1"},

      {:ex_doc, "~> 0.13", only: :dev}
    ]
  end
end
