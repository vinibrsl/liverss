# LiveRSS
Stream RSS feeds with this GenServer.

![Asciicinema](https://i.imgur.com/lGSEWCJ.gif)

```elixir
LiveRSS.Pool.start_link(
  name: :new_york_times,
  url: "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
  refresh_every: :timer.hours(2)
)

LiveRSS.get(:new_york_times)

# %FeederEx.Feed{
#   id: nil,
#   author: nil,
#   entries: [],
#   image: "https://static01.nyt.com/images/misc/NYT_logo_rss_250x40.png",
#   language: "en-us",
#   link: "https://www.nytimes.com/section/world",
#   subtitle: nil,
#   summary: nil,
#   title: "NYT > World News",
#   updated: "Tue, 12 Jul 2022 00:11:46 +0000",
#   url: "https://rss.nytimes.com/services/xml/rss/nyt/World.xml"
# }
```

## Installation
The package can be installed using [hex.pm](http://hex.pm/packages/liverss) by adding
`liverss` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:liverss, "~> 0.1.0"}
  ]
end
```

## Documentation
The documentation for this library can be found at [HexDocs](https://hexdocs.pm/liverss/).
