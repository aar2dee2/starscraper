mix local.hex --if-missing --force
mix local.rebar --force

cd starscraper
mix deps.get
mix deps.compile

mix run lib/nft.exs