defmodule Timber do

  def split(descr) do split(descr, 0, [], []) end

  def split([], n, left, right) do [{:split, n, left, right}] end
  def split([s], n, [], right) do
    [{:split, n+s, [s], right}]
  end
  def split([s], n, left, []) do
    [{:split, n+s, left, [s]}]
  end
  def split([ s | rest], n, left, right) do
    split(rest, n + s, [s | left], right) ++ split(rest, n + s, left, [s | right])
  end



  def check(descr, mem) do
   #
    case Map.get(mem, descr) do
      nil ->
        {answer, mem} = cost(descr, mem)
        {answer, Map.put(mem, descr, answer)}
      answer ->
        {answer, mem}
    end
  end

  def cost(descr) do
    {{c, _}, _} = cost(descr, Map.new())
    c
  end

  #HUFFMAN
  def cost([], mem) do {{0, :na}, mem} end
  def cost([s], mem) do {{0, s}, mem} end
  def cost(descr, mem) do cost(descr, 0, [], [], mem) end

  def cost([], n, left, right, mem) do
    {{c1, t1}, mem} = check(left, mem)
    {{c2, t2}, mem} = check(right, mem)
    {{n + c1 + c2, {:tr, t1, t2}}, mem}
  end
  def cost([s], n, [], right, mem) do cost([], n+s, [s], right, mem) end
  def cost([s], n, left, [], mem) do cost([], n+s, left, [s], mem) end
  def cost([s | rest], n, left, right, mem) do
    {{c1, t1}, mem} = cost(rest, n+s, [s | left], right, mem)
    {{c2, t2}, mem} = cost(rest, n+s, left, [s | right], mem)
    if c1 < c2 do
      {{c1, t1}, mem}
    else
      {{c2, t2}, mem}
    end
  end

  def test do
    cost([1,2,3])
  end

end
