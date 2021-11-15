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

  def get_common_glossary() do
    case HTTPoison.get("https://skyandtelescope.org/astronomy-terms/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, document} = Floki.parse_document(body)
        names = 
          document
          |> Floki.find("p strong")
          |> Enum.map(&elem(&1, 2) |> Enum.fetch!(0))
        #&Enum.fetch!(&1, 2)
        {:ok, names}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
  
  #Below are common helper functions
  def extract_names(l) do
    Enum.map(l, fn a -> 
        cond do
          is_binary(a) -> a
          is_tuple(a) -> 
            case elem(a, 2) |> Enum.fetch(0) do
              {:ok, something} -> something
              _ -> ""
            end
          is_list(a) -> 
            case Enum.fetch(a, 0) do
              {:ok, something} -> something
              _ -> ""
            end
          is_tuple(Enum.fetch!(a, 0)) -> 
            outer = Enum.fetch!(a, 0) |> elem(2) |> Enum.fetch!(0)
              if is_binary(outer) do
                outer
              else
                elem(outer, 2) |> Enum.fetch!(0)
              end
          #is_list(Enum.fetch!(a, 0)) -> 
            #Enum.fetch!(a, 0) |> elem(2) |> Enum.fetch!(0) |> elem(2) |> Enum.fetch!(0)
          true -> 
            Enum.fetch!(a, 0)
        end
    end) |> Enum.filter(
      fn x -> is_binary(x) && String.length(x) > 0 end)
  end

  @doc """
  get words, all with the first letter capitalized, from a list of strings where there may be single-word or multi-word string
  """
  def extract_words(l) do
    Enum.map(l, &String.split(&1, [" ", "@", "$", ",", "!", "#", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", ";", ":", "'", ".", "/", "?", "|", "\\"])) |> List.flatten() |> Enum.filter(
      fn x -> !Regex.match?(~r{[^a-z|A-Z]}, x) && x != "" && x != " " end
      )
  end
end
