defmodule Ranges do

  #FILEREADER
  def fileread do
    samplestring = File.read!("lib/sample.txt")
    [seeds | maps] = String.split(samplestring, "\n\n")
    [_ | seeds] = String.split(seeds, " ")
    seeds = Enum.map(seeds, fn(x) -> {nr, _} = Integer.parse(x); nr end)
    maps = Enum.map(maps, fn(x) -> String.split(x, "\n") end)
    maps = Enum.map(maps, fn(x) ->
      [_ | nums] = x
      nums = Enum.map(nums, fn(y) -> z = String.split(y, " ");
        [to, from, length] = Enum.map(z, fn(x) -> {nr, _} = Integer.parse(x); nr end);
        {:tr, to, from, length}
      end)
      {:map, nums}
    end)
    {seeds, maps}
  end


  def test do
    #fileread()
    {seeds, maps} = fileread()
    #resultlist = transformation({seeds, maps})
    #IO.inspect(Enum.min(resultlist))
   # minval(resultlist)
  end

  #TRANSFORMATION ALGORITHM
  def transformation({seeds, maps}) do transformation(seeds, maps) end

  def transformation([], _) do [] end
  def transformation([seed | rest], maps) do
    [ transform(seed, maps) | transformation(rest, maps) ]
  end

  def transform(num, []) do num end
  def transform(num, [{:map, trs} | rest]) do
    new_num = transf(num, trs)
    #IO.puts("value:  #{inspect(new_num)}")
    transform(new_num, rest)
  end

  def transf(num, []) do num end
  def transf(num, [{:tr, to, from, length} | t]) do
      if num >= from and num <= (from + length - 1) do
        dif = num - from
        ret = to + dif
        ret  #no further transf() because only 1 change per map
      else
        transf(num, t)
      end
  end


  #MINIMUM VALUE
  def minval([h | t]) do minval(t, h, fn(x, acc) -> min(x, acc) end) end
  def minval([], acc, _) do acc end
  def minval([h | t], acc, op) do minval(t, op.(h, acc), op) end










end
