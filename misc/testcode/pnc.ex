defmodule PnC do
  
  @moduledoc """
  Contains function to generate arrangements and combinations of objects in lists.
  """
  @doc """
  Call the combinations function on a list with number of objects from 2 to n.

  ## Examples
      iex> comb_helper(["1", "2", "3", "4"], 2, 4, [])
      [
      ["1", "2"],
      ["1", "3"],
      ["1", "4"],
      ["2", "3"],
      ["2", "4"],
      ["3", "4"],
      ["1", "2", "3"],
      ["1", "2", "4"],
      ["1", "3", "4"], 
      ["2", "3", "4"],
      ["1", "2", "3", "4"]
      ]
  """
  def comb_helper(_names, counter, n, result) when counter > n do
    result
  end

  def comb_helper(names, counter, n, result) do
    new = result ++ combinations(names, counter)
    comb_helper(names, counter + 1, n, new)
  end
  
  @doc """
  Generates all possible combinations of objects in a list - arrangement of objects does not matter - where num out of n objects are chosen for each list.
  Ref: https://elixirforum.com/t/generate-all-combinations-having-a-fixed-array-size/26196/16

  ## Examples
      iex> combinations(["1", "2", "3"], 2)
      [["1", "2"], ["1", "3"], ["2", "3"]]
  """
  @doc since: "1.12.2"
  @spec combinations(list(), integer()) :: list(list())
  def combinations(_list, 0), do: [[]]
  def combinations([], _num), do: []

  def combinations([head | tail], num) do
    Enum.map(combinations(tail, num - 1), &[head | &1]) ++
    combinations(tail, num)
  end
  
  @doc """
  A helper function to call the perm function on each list in a list of lists.

  """
  def perm_helper([], result) do
    result
  end

  def perm_helper(combs, result) do
    [head | tail] = combs
    new = perm(head)
    perm_helper(tail, result ++ new)
  end

  @doc """
  Generates all possible uniques arrangements (permutations) of objects in a list - each arrangements includes all objects.
  Ref: https://elixirforum.com/t/most-elegant-way-to-generate-all-permutations/2706

  """
  @doc since: "1.12.2"
  @spec perm(list()) :: list(list())
  def perm([]), do: [[]]
  def perm(names), do: for x <- names, rest <- perm(names--[x]), do: [x|rest]

end