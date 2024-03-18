defmodule Day5 do

  def test do
    descr = sample()
    parse(descr)
    #locations = Enum.map(seeds, fn(seed) -> transform(maps, seed) end)
    #Enum.reduce(locations, :inf, fn(x, acc) -> min(x,acc) end)

  end

  def transform(maps, seeds) do
    Enum.reduce(maps, seeds, fn(map, sofar) -> transf(map, sofar) end)
  end

  def transf(trs, nr) do
    case Enum.filter(trs, fn({:tr, _, from, length}) -> (nr >= from) and (nr <= (from+length-1)) end) do
      [] ->
        nr
      [{:tr, to ,from, _}] ->
        (nr - from) + to
    end
  end


  def parse(descr) do
    [seeds | maps] = String.split(descr, "\n\n")
    [_ | seeds] = String.split(seeds, " ")
    #seeds = String.split(x, " ")
    seeds = Enum.map(seeds, fn(x) -> {nr, _} = Integer.parse(x); nr end)
    maps = Enum.map( maps, fn(map) ->
      [_, map] = String.split(map, ":")
    #  map = String.split(map, "\n")
    #  Enum.map(map, fn(mp) ->
    #    IO.inspect(mp)
    #    [to, from, length] = Enum.map(String.split(mp, " "), fn(x) -> {nr, _} = Integer.parse(x); nr end)
    #    {:tr, from, to, length}
    #  end)
    end)

   # {seeds, maps}
  end



  def sample() do
    "seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
    "
  end

end
