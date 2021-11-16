# Starscraper

[![Run on Repl.it](https://repl.it/badge/github/aar2dee2/starscraper)](https://repl.it/github/aar2dee2/starscraper)

Starscraper is a spacecraft name NFT generator that:
  - fetches names of constellations, fictional spacecraft and common space terms from web links using the [HTTPoison](https://github.com/edgurgel/httpoison) and [Floki](https://github.com/philss/floki) libraries
  - creates a list of words from these names using Elixir standard library functions
  - generates names for spacecraft based on combinations of words from the list above - using the `erlang random` module here.
  - creates a jpeg for each name selected using the [mogrify](https://github.com/elixir-mogrify/mogrify) library and [ImageMagick](http://www.imagemagick.org/script/index.php)

  
  ---
  __Note:__ ImageMagick has been added as a Nix package in `replit.nix`