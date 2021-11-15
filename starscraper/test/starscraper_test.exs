defmodule StarscraperTest do
  use ExUnit.Case
  doctest Starscraper

  test "greets the world" do
    assert Starscraper.hello() == :world
  end
end
