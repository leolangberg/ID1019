defmodule Springs do

  def parse_rows([]) do [] end
  def parse_rows([h | t]) do [ parse(h) | parse_rows(t)] end

  def parse(row) do
    row = String.trim(row)
    [springs, damaged_sizes] = String.split(row, " ")
    damaged_sizes = parse_damaged_sizes(damaged_sizes)
    springs = parse_springs(springs)
    springs = String.to_charlist(springs)
    {springs, damaged_sizes}

  end

  def parse_springs(str) do
    basestr = Enum.join([str, str], "?")
    basestr = Enum.join([basestr, str], "?")
    basestr = Enum.join([basestr, str], "?")
    basestr = Enum.join([basestr, str], "?")
    basestr = Enum.join([basestr, str], "?")
  end

  def parse_damaged_sizes(str) do
    basestr = String.split(str, ",")
    basestr = Enum.map(basestr, fn(x) -> {nr, _} = Integer.parse(x); nr end)
    str = append(basestr, basestr)
    str = append(str, basestr)
    str = append(str, basestr)
    str = append(str, basestr)
    str = append(str, basestr)
  end

  def append([], rest) do rest end
  def append([h | t], rest) do [h | append(t, rest)] end

  def test do

    sample = String.split(Springs2.sample(), "\n")
    sample = parse_rows(sample)
    sample = springs(sample)
    total = sum(sample)

  end

  def sum([]) do 0 end
  def sum([h | t]) do h + sum(t) end


  def springs([]) do [] end
  def springs([h | t]) do
    #IO.inspect(h)
    [ search(h) | springs(t)]
  end






  def search({chars, nums}) do search(chars, nums) end

  def search([],[]) do 1 end
  def search([], nums) do 0 end
  def search([chars | t], []) do
    case chars do
      ?# -> 0
      _ -> search(t, [])
    end
  end
  def search([char | t1],[num | t2]) do
   # IO.puts("MAINSEARCH #{inspect([char | t1])} #{inspect([num | t2])}")
    case char do
      ?# ->
        case damaged(t1, num-1) do
          {:ok, rest} ->
            search(rest, t2) #if this is true then next has to be "."
          :error ->
            0
        end
      ?. ->
        search(t1, [num | t2])
      ?? ->
        search([?# | t1], [num | t2]) + search([?. | t1], [num | t2])
    end
  end

  def damaged([], 0) do {:ok, []} end
  def damaged([rest | t], 0) do
    if rest != ?# do
     {:ok, t}
    else
      :error
    end
  end   #når 0 med (rest) kvar
  def damaged([?# | t], num) do damaged(t, num-1) end
  def damaged([?? | t], num) do damaged(t, num-1) end
  def damaged(_, num) do :error end


















  def sample2() do
    "???.### 1,1,3"

  end
  def sample do

    "???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1"

  end

end
