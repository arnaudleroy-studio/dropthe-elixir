# DropThe

[![Hex.pm](https://img.shields.io/hexpm/v/dropthe.svg)](https://hex.pm/packages/dropthe)

Elixir client for the DropThe open data platform. DropThe is a data utility media network that
tracks over 25,000 movies, 15,000 series, 10,000 cryptocurrencies, and 1,800+ entities spanning
companies and public figures. This library provides structured access to those datasets through
a consistent, pipe-friendly API.

## Installation

Add `dropthe` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dropthe, "~> 0.1.2"}
  ]
end
```

## Quick Start

Fetch an API endpoint URL for a specific entity type:

```elixir
DropThe.endpoint(:movies)
|> IO.puts()
# "https://dropthe.org/api/v1/movies"

DropThe.endpoint(:crypto)
|> IO.puts()
# "https://dropthe.org/api/v1/crypto"
```

Use pattern matching to branch on available categories:

```elixir
case DropThe.category_info(:movies) do
  %{name: name, count: count} ->
    IO.puts("#{name}: #{count} entries tracked")

  :unknown ->
    IO.puts("Category not recognized")
end
```

Build query parameters with keyword lists, then construct a full request URL:

```elixir
params = [type: "movies", sort: "popularity", limit: 20]

params
|> DropThe.build_query()
|> then(&"#{DropThe.endpoint(:movies)}?#{&1}")
|> IO.puts()
# "https://dropthe.org/api/v1/movies?type=movies&sort=popularity&limit=20"
```

List all verticals the platform covers:

```elixir
DropThe.categories()
|> Enum.each(fn {key, label} ->
  IO.puts("#{key} -> #{label}")
end)
```

## Available Data

The platform organizes content across several verticals. Movies and series include metadata
like cast, ratings, streaming availability, and release dates. The crypto vertical tracks
live prices, market caps, and historical data for thousands of tokens. Company profiles cover
founding details, leadership, and industry classification. People entities link actors,
directors, and executives to the works and organizations they are associated with. All data
is interconnected through a knowledge graph of nearly 3 million entity relationships.

## Links

- [DropThe Platform](https://dropthe.org) -- browse movies, crypto, and company data
- [Source Code](https://github.com/arnaudleroy-studio/dropthe-elixir)

## License

MIT -- see [LICENSE](LICENSE) for details.
