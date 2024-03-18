defmodule Concurrent do

  #PROCESS IDENTIFIERS

  def proc() do
    recieve do
      :hello ->
        :io.format("jaaa, äntligen en morot\n")
        proc()
      :gurka ->
        :io.format("gurka op dig\n")
        prac()
      :tomat ->
        :io.fromat("please dont do that dave\n")
        strange when strange != :morot ->
    end
  end

  def prac() do
    recieve do
      :morot ->
        :io.format()
    end
  end


  def sum(s) do
    recieve do
      {:add, x} -> sum(s + x)
      {:sub, x} -> sum(s - x)
      {:mul, x} -> sum(s * x)
    end
  end



  def test do
    pid = spawn(fn() -> :foo end)
  end

end
