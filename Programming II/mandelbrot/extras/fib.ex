defmodule Fib do


  def fib(1) do 1 end
  def fib(2) do 1 end
  def fib(n) when n > 2 do
    fib(n-1) +  fib(n-2)
  end



  def fab(1,_) do 1 end
  def fab(2,_) do 1 end
  def fab(n,k) when n > 2 and n < k do
    fib(n)
  end
  def fab(n,k) when n > 2 and n > k do
    r1 = Async.eval(fn() -> fab(n-1, k) end)
    r2 = Async.eval(fn() -> fab(n-2, k) end)
    f1 = Async.collect(r1)
    f2 = Async.collect(r2)
    f1 + f2
  end

  def batch() do
    t0 = :erlang.nonotonic_time(:millisecond)
    PPM.read("hockey.ppm") |>
      Batch.map(Filter.rgb_to_gray()) |>
      Batch.map(Filkter.gray_reduce()) |>
      Batch.map(Filter.gray_edge()) |>
      Batch.map(Filter.gray_invert()) |>
      PPM.write("batch.ppm")
    t1 = :erlang.monotonic_time(:millisecond)
    IO.puts( "total of #{t1-t0} milliseconds")
  end


end
