defmodule Bench do

  def bench() do

   # {springs, _} = :timer.tc(fn() -> Springs.test() end)

    {springs2, _} = :timer.tc(fn() -> Springs2.test() end)

    IO.puts("SPRINGS:   SPRINGS2: #{springs2}")

  end

end
