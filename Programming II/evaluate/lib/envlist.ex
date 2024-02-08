defmodule EnvList do

  #Helper functions
  def append([], y) do y end
  def append([h | t], y) do [ h | append(t,y)] end

  def reverse([]) do [] end
  def reverse([h | t]) do append(reverse(t), [h]) end


  #Main functions
  def new do [] end

  #def add(map, key, value) do [{key, value} | map] end
  def add([], key, value) do [{key, value}] end
  def add([{key, _} | map], key, value) do [{key, value} | map] end
  def add([h | map], key, value) do [h | add(map, key, value)] end

  def lookup(map, key) do member(map, key) end
  def member([], _) do nil end
  def member([{key, value} | _], key) do value end
  def member([_ | t], key) do member(t, key) end


  def remove([], _) do [] end
  def remove([{key, _} | t], key) do t end
  def remove([ h | t ], key ) do [ h | remove(t, key)] end





  def test do

    map = new()
    cur = add(map, :a, 1)
    IO.inspect(cur)
    cur2 = add(cur, :b, 2)
    IO.inspect(cur2)
    cur3 = add(cur2, :c, 3)
    IO.inspect(cur3)
    cur4 = add(cur3, :d, 4)
    IO.inspect(cur4)



  end

end
