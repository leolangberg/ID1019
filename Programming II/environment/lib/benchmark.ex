defmodule Benchmark do

  def random_number_generator do
    Enum.map(1..5, fn(_) -> :rand.uniform(10) end)
  end

  def bench_list(i, n) do

    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
    list = Enum.reduce(seq, EnvList.new(), fn(e, list) -> EnvList.add(list, e, :foo) end)

    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

    {add, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvList.add(list, e, :foo) end) end)

    {lookup, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvList.lookup(list, e) end) end)

    {remove, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvList.remove(list, e) end) end)

    {i, add, lookup, remove}
  end

  def bench_tree(i, n) do

    seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
    list = Enum.reduce(seq, EnvTree.new(), fn(e, list) -> EnvTree.add(list, e, :foo) end)

    seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)

    {add, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvTree.add(list, e, :foo) end) end)

    {lookup, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvTree.lookup(list, e) end) end)

    {remove, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> EnvTree.remove(list, e) end) end)

    {i, add, lookup, remove}
  end

  def bench(n) do
    #ls = [16, 32, 64, 128, 256, 512, 1024, 2*1024, 4*1024, 8*1024]
    ls = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

    :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
    :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])

    Enum.each(ls, fn (i) -> {i, tla, tll, tlr} = bench_list(i, n)
    :io.format("~6.w~12.2f~12.2f~12.2f\n", [i, tla/n, tll/n, tlr/n])
    end)
  end

end
