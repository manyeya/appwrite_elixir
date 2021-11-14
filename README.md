# AppwriteElixir

Welcome to our documentation section. Here you will be able to find quick guides to setup and integrate with AppwriteElixir on your Elixir Project. You can also review full and detailed API references to all of our Appwrite's services.

## Installation

[available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `appwrite_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:appwrite_elixir, "~> 0.1.1"}
  ]
end
```

Then in your config file

```elixir
#config/config.exs
config :appwrite_elixr,
    :project_id "YOUR_PROJECT_ID",
    :api_key "YOUR_API_KEY",
    :host "YOUR_HOST" # defaults to localhost
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/appwrite_elixir](https://hexdocs.pm/appwrite_elixir).
