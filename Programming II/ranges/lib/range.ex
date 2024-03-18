defmodule Range do

  def infinity() do fn() -> infinity(0) end end
  def infinity(n) do  [n | fn() -> infinity(n+1) end] end

  def fibonacci() do fn() -> fibonacci(1,1) end end
  def fibonacci(n1, n2) do [ n1 | fn() -> fibonacci(n2, n1+n2) end] end

  #{:range, 1, 10}    xs = 1..10    Enum.take(xs, 10)

  def sum({:range, from, from}) do from end
  def sum({:range, from, to}) do from + sum({:range, from + 1, to}) end

  def foldl({:range, from, from}, acc, op) do op.(from, acc) end
  def foldl({:range, from, to}, acc, op) do
    foldl({:range, from+1, to}, op.(from, acc), op)
  end

  def map(range, op) do map( range, [], op) end
  def map({:range, from, from}, acc, op) do [op.(from)| acc] end
  #def map({:range, from, to}, acc, _) when from > to do acc end
  def map({:range, from, to}, acc, op) do
    [ op.(from) | map({:range, from + 1, to}, [op.(from) | acc], op)]
  end

  def filter(range, op) do filter(range, [], op) end
  def filter({:range, from, from}, acc, op) do
    if op.(from) do
      [from | acc]
    else
      acc
    end
  end
  def filter({:range, from, to}, acc, op) do
    if op.(from) do
      [ from | filter({:range, from+1, to}, [from | acc], op)]
    else
      filter({:range, from + 1, to}, acc, op)
    end
  end

  def take(range, n) do take(range, [], n) end
  def take(_, acc, 0) do Enum.reverse(acc) end
  def take({:range, from, to}, acc, n) do
    take({:range, from+1, to}, [from | acc], n-1)
  end


  def reduce({:range, from, to}, {:cont, acc}, _) when from > to do {:done, acc} end
  def reduce({:range, from, to}, {:cont, acc}, op) do
    reduce({:range, from+1, to}, op.(from, acc), op)
  end
  def reduce(_ , {:halt, acc}, _) do {:halted, acc} end
  def reduce( range, {:suspend, acc}, op) do {:suspended, acc, fn(cmd) -> reduce( range, cmd, op) end} end


  def head(range) do reduce(range, {:cont, :na}, fn(x, _) -> {:suspend, x} end) end


  def mup(range, op) do reduce(range,{:cont, []}, fn(x, acc) -> {:cont, [op.(x) | acc]} end) end


  def falter(range, op) do
    reduce(range, {:cont, []}, fn(x, acc) ->
        if op.(x) do
          {:cont, [x | acc]}
        else
         {:cont, acc}
        end
      end)
  end


  def tuke(range, n) do {_, {_ , taken}} = reduce(range, {:cont, {n, []}}, fn(x, acc) ->
      case acc do
        {0, taken} ->
          {:halt, {0, taken}}
        {n, taken} ->
          {:cont, {n-1, [x | taken]}}
        end
      end)
      taken
  end



  def test do

    mup({:range, 1, 10}, fn(x) -> x*x end)
    falter({:range, 1, 10}, fn(x) -> rem(x,2) == 0 end)
    tuke({:range, 1, 100}, 5)
    head({:range, 1, 10})


    #iex(63)> {:suspended, n, f} = Range.head({:range, 1, 10})
    #{:suspended, 1, #Function<7.57943685/1 in Range.reduce/3>}
    #iex(64)> {:suspended, n, f} = f.({:cont, f})
    #{:suspended, 2, #Function<7.57943685/1 in Range.reduce/3>}
    #iex(65)> {:suspended, n, f} = f.({:cont, f})
    #{:suspended, 3, #Function<7.57943685/1 in Range.reduce/3>}
    #iex(66)> {:suspended, n, f} = f.({:cont, f})


  end
end
