defmodule Day1b do

  def test() do
    sample = sample()
    rows = to_rows(String.to_charlist(sample))
    parsed = parse_rows(rows)
    sum(parsed)
  end

  def sum([]) do 0 end
  def sum([{first, last} | rest]) do first*10 + last + sum(rest) end

  def parse_rows([]) do [] end
  def parse_rows([row | rest]) do [ parse_row_b(row) | parse_rows(rest)] end

  def parse_row_b(row) do
    {first, rest} = parse_first_b(row)
    last = parse_last_b(rest, first)
    {first, last}
  end

  def parse_last_b([], last) do last end
  def parse_last_b([ char | rest], sofar) do
    last = case char do #last here different variable
      ?0 -> 0
      ?1 -> 1
      ?2 -> 2
      ?3 -> 3
      ?4 -> 4
      ?5 -> 5
      ?6 -> 6
      ?7 -> 7
      ?8 -> 8
      ?9 -> 9
      _  -> sofar
    end
    parse_last_b(rest, last)
  end

  def parse_first_b([?o, ?n, ?e | rest]) do {1, [?e | rest]} end
  def parse_first_b([?t, ?w, ?o | rest]) do {2, [?o | rest]} end
  def parse_first_b([?t, ?h, ?r, ?e, ?e | rest]) do {3, [?e | rest]} end

  def parse_first_b([ char | rest]) do
    case char do #?0 gives ASCII value
      ?0 -> {0, rest}
      ?1 -> {1, rest}
      ?2 -> {2, rest}
      ?3 -> {3, rest}
      ?4 -> {4, rest}
      ?5 -> {5, rest}
      ?6 -> {6, rest}
      ?7 -> {7, rest}
      ?8 -> {8, rest}
      ?9 -> {9, rest}
      _  -> parse_first_b(rest)
    end
  end

  def to_rows( [] ) do [[]] end
  def to_rows( [?\n | rest] ) do [[] | to_rows(rest)] end
  def to_rows( [char | rest] ) do [last | rows] = to_rows(rest); [[char | last] | rows] end

  def sample() do

  end
end
