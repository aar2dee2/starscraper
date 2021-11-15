defmodule Starscraper do
  @moduledoc """
  Documentation for `Starscraper`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Starscraper.hello()
      :world

  """
  def hello do
    :world
  end

  def get_spacecraft_name() do
    case HTTPoison.get("https://en.wikipedia.org/wiki/List_of_fictional_spacecraft") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, document} = Floki.parse_document(body)
        names = 
          document
          |> Floki.find("i")
          |> Enum.map(&elem(&1, 2))
        #&Enum.fetch!(&1, 2)
        {:ok, names}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def extract_names(l) do
    Enum.map(l, fn a -> 
        if is_tuple(Enum.fetch!(a, 0)) do
          Enum.fetch!(a, 0) |> elem(2) |> Enum.fetch!(0)
          #Enum.fetch!(a, 0)
        
        else
          #Enum.fetch!(a, 0) |> elem(2) |> Enum.fetch!(0)
          Enum.fetch!(a, 0)
        end
    end)
  end

  @doc """
  get words, all with the first letter capitalized, from a list of strings where there may be single-word or multi-word string
  """
  def extract_words(l) do
    Enum.map(l, &String.split(&1, " ")) |> List.flatten()
  end
end
