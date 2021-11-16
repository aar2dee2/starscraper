defmodule Comb do

  def comb_helper(names, word_count, counter, n, result) when length(names) <= counter do
    result
  end

  def comb_helper(names, word_count, counter, n, result) do
    new = result ++ combinations(names, counter)
    comb_helper(names, counter + 1, n, new)
  end

  #change the function head to implement condition when result is returned. Will it be when names = []?
  def combinations(names, counter, n, result) do
    result
  end

  def combinations([head | tail] = names, counter, n, result) do
    [head] ++ Enum.map(0..length(tail - counter - 1))
  end

end