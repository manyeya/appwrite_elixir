defmodule AppwriteElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :appwrite_elixir,
      version: "0.1.0",
      elixir: "~> 1.12",
      description: "Appwrite sdk for Elixir",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AppwriteElixir.Application, []},
      applications: [:httpoison, :jason]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: ["manyeya"],
      licenses: ["MIT"],
      links: %{
        "github" => "https://github.com/manyeya/appwrite_elixir",
        "docs" => "http://hexdocs.pm/appwrite_elixir/"
      }
    ]
  end
end
