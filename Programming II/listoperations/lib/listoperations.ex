defmodule Listoperations do


 # def sum([]) do 0 end
 # def sum([h | t]) do add(h, sum(t)) end

  #def prod([]) do 1 end
 # def prod([h | t]) do mul(h, prod(t)) end


 # def foldr([], acc, op) do acc end #acc signals end of list
 # def foldr([h|t], acc op) do op.(h, foldr(t, acc, op)) end


  #def foo(x) do foldr(x, 0, fn(_, b) -> b + 1 end) end
  def foo(x) do foldr(x, [], fn(a,b) -> b ++ [a] end) end
  def foldr([], acc, _) do acc end
  def foldr([h | t], acc, op) do op.(h, foldr(t, acc, op)) end

  def foldl([], acc, op) do acc end
  def foldl([h|t], acc, op) do foldl(t, op.(h, acc), op) end  #svansrekursiv --> lägger inte saker på stacken tills vidare (gör saker på vägen tillbaka)

  def flattenr(x) do #(n)
    f = fn(e,a) -> e ++ a end
    foldr(x, [], f)
  end

  def flattenl(x) do  #slower because has to iterate same growing list each time (n^2)
    f = fn(a, acc) -> acc ++ a end
    foldl(x, [], f)
  end

  def map([], _) do [] end
  def map([h | t], op) do [ op.(h) | map(t, op) ] end

  def filter([], _) do [] end
  def filter([h | t], op)
    if op.(h) do
      [h | filter(t, op)]
    else
      filter(t, op)
    end
  end


end
