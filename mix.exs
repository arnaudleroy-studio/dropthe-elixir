defmodule DropThe.MixProject do
  use Mix.Project

  def project do
    [
      app: :dropthe,
      version: "0.1.1",
      elixir: "~> 1.14",
      description: "Access open datasets for movies, series, crypto, companies from DropThe.",
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/arnaudleroy-studio/dropthe-elixir",
      homepage_url: "https://dropthe.org"
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "Homepage" => "https://dropthe.org",
        "GitHub" => "https://github.com/arnaudleroy-studio/dropthe-elixir",
        "Documentation" => "https://dropthe.org/data/"
      }
    ]
  end

  defp docs do
    [
      main: "DropThe",
      extras: ["README.md"]
    ]
  end
end
