defmodule DropThe do
  @moduledoc """
  Elixir client for the DropThe open data platform.

  DropThe tracks over 25,000 movies, 15,000 series, 10,000 cryptocurrencies,
  and 1,800+ entities spanning companies and public figures. This module
  provides endpoint construction, category metadata, and query building
  helpers for accessing the platform's datasets.

  ## Usage

      DropThe.endpoint(:movies)
      # "https://dropthe.org/api/v1/movies"

      DropThe.categories()
      |> Enum.map(fn {k, v} -> {k, v} end)

  See the [DropThe platform](https://dropthe.org) for available data.
  """

  @version "0.1.2"
  @base_url "https://dropthe.org"

  @categories %{
    movies: %{name: "Movies", count: 25_000, slug: "movies"},
    series: %{name: "Series", count: 15_000, slug: "series"},
    crypto: %{name: "Cryptocurrencies", count: 10_000, slug: "crypto"},
    companies: %{name: "Companies", count: 500, slug: "companies"},
    people: %{name: "People", count: 1_800, slug: "people"}
  }

  @doc """
  Returns the library version.

  ## Examples

      iex> DropThe.version()
      "0.1.2"
  """
  @spec version() :: String.t()
  def version, do: @version

  @doc """
  Returns the base URL of the DropThe platform.

  ## Examples

      iex> DropThe.base_url()
      "https://dropthe.org"
  """
  @spec base_url() :: String.t()
  def base_url, do: @base_url

  @doc """
  Returns a map of all available data categories with their metadata.

  Each category includes a display name, approximate entity count, and URL slug.

  ## Examples

      iex> categories = DropThe.categories()
      iex> Map.has_key?(categories, :movies)
      true
      iex> categories[:movies].name
      "Movies"
  """
  @spec categories() :: %{atom() => %{name: String.t(), count: non_neg_integer(), slug: String.t()}}
  def categories, do: @categories

  @doc """
  Returns metadata for a specific category, or `:unknown` if not recognized.

  ## Examples

      iex> DropThe.category_info(:crypto)
      %{name: "Cryptocurrencies", count: 10000, slug: "crypto"}

      iex> DropThe.category_info(:invalid)
      :unknown
  """
  @spec category_info(atom()) :: %{name: String.t(), count: non_neg_integer(), slug: String.t()} | :unknown
  def category_info(category) do
    Map.get(@categories, category, :unknown)
  end

  @doc """
  Builds the full API endpoint URL for a given category.

  ## Examples

      iex> DropThe.endpoint(:movies)
      "https://dropthe.org/api/v1/movies"

      iex> DropThe.endpoint(:crypto)
      "https://dropthe.org/api/v1/crypto"
  """
  @spec endpoint(atom()) :: String.t()
  def endpoint(category) when is_atom(category) do
    case category_info(category) do
      :unknown -> "#{@base_url}/api/v1/#{category}"
      %{slug: slug} -> "#{@base_url}/api/v1/#{slug}"
    end
  end

  @doc """
  Returns a list of all API endpoint URLs.

  ## Examples

      iex> endpoints = DropThe.endpoints()
      iex> length(endpoints)
      5
  """
  @spec endpoints() :: [String.t()]
  def endpoints do
    @categories
    |> Map.keys()
    |> Enum.map(&endpoint/1)
    |> Enum.sort()
  end

  @doc """
  Encodes a keyword list into a URL query string.

  ## Examples

      iex> DropThe.build_query(type: "movies", sort: "popularity", limit: 20)
      "type=movies&sort=popularity&limit=20"
  """
  @spec build_query(keyword()) :: String.t()
  def build_query(params) when is_list(params) do
    params
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end

  @doc """
  Returns platform information as a map.

  ## Examples

      iex> info = DropThe.info()
      iex> info.name
      "DropThe"
      iex> info.version
      "0.1.2"
  """
  @spec info() :: %{name: String.t(), version: String.t(), base_url: String.t(), total_entities: non_neg_integer()}
  def info do
    total = @categories |> Map.values() |> Enum.map(& &1.count) |> Enum.sum()

    %{
      name: "DropThe",
      version: @version,
      base_url: @base_url,
      total_entities: total
    }
  end
end
