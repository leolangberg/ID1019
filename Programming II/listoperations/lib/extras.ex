defmodule Extras do

  #MERGESORT
  def sort([], _) do [] end
  def sort([x], _) do [x] end
  def sort(lst, less) do
    IO.write("sort")
    {lst1, lst2} = split(lst, less)
    sorted1 = sort(lst1, less)
    sorted2 = sort(lst2, less)
    merge(sorted1, sorted2, less)
  end

  def split([]) do {[], []} end
  def split([a | t], less) do
    {s1, s2} = split(t, less)
    {s2, [a | s1]} #swaps list to put in each iteration
  end

  def merge([], []) do [] end
  def merge([], b) do b end
  def merge(a, []) do a end
 def merge([h1 | t1], [h2 | t2], less) do
  #if h1 < h2 do
  if less.(h1,h2) do
     [ h1 | merge(t1, [h2 | t2], less) ]
    else
      [ h2 | merge([h1 | t1], t2, less) ]
    end
  end


  def card_less({:card, suite, n1}, {:card, suite, n2}) do n1 < n2 end
  def card_less(_, {:card, :spade, _}) do true end
  def card_less(_, {:card, :heart, _}) do false end
  def card_less({:card, :spade, _}, _) do true end
  def card_less(_,_) do false end




 # inf = infinity(); [0 | inf] = inf.(); [ 1 | inf] = inf.()

  def infinity do
    fn() -> [0 | :gurka ] end
  end

end
