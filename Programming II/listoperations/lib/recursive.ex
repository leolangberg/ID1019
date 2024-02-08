defmodule Recursive do

  def längd([]) do 0 end
  def längd([_ | t]) do 1 + längd(t) end

  def even([]) do [] end
  def even([h | t]) do
    if rem(h, 2) == 0 do
      [h | even(t)]
    else
      even(t)
    end
  end

  def inc([], _) do [] end
  def inc([h | t], n) do [(h + n) | inc(t,n)] end

  def sum([]) do 0 end
  def sum([h | t]) do h + sum(t) end

  def dec([], _) do [] end
  def dec([h | t], n) do [(h - n) | dec(t,n)] end

  def mul([], _) do [] end
  def mul([h | t], n) do [(h * n) | mul(t,n)] end

  def odd([]) do [] end
  def odd([h | t]) do
    if rem(h,2) == 0 do
      odd(t)
    else
      [h | odd(t)]
    end
  end

  def remainder([], _) do [] end
  def remainder([h | t], n) do [rem(h, n) | remainder(t,n)] end

  def prod([]) do 1 end
  def prod([h | t]) do h * prod(t) end

  def division([], _) do [] end
  def division([h | t], n) do
    if rem(h, n) == 0 do
      [(h / n) | division(t,n)]
    else
      division(t,n)
    end
  end
end
