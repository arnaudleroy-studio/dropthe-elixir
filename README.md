# DropThe Elixir Client

Elixir client for the [DropThe](https://dropthe.org) open data API. Access datasets for movies, series, crypto, and companies.

## Installation

Add `dropthe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dropthe, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
DropThe.version()
# => "0.1.0"

DropThe.base_url()
# => "https://dropthe.org"
```

## Links

- [Homepage](https://dropthe.org)
- [Documentation](https://dropthe.org/data/)
- [GitHub](https://github.com/arnaudleroy-studio/dropthe-elixir)

## License

MIT License. See [LICENSE](LICENSE) for details.
