defmodule Extras do
#def foo(x, y) do
   # try do
    #  {:ok, bar(x, y)}
    #rescue
     # error


     def append([], y) do y end
     def append([h|t], y) do
       z = append(t, y)
       [h | z]
     end

     def append2([], y) do y end
     def append2([h | t], y) do
       [ h | append(t,y)]
     end

     def union([], y) do y end
     def union([h | t], y) do
       z = union(t, y)
       [h | z]
     end

     def tailr([], y) do y end
     def tailr([h | t], y) do
       z = [h | y]
       tailr(t,z)
     end

     def rev([]) do [] end
     def rev([h | t]) do
       rev(t) ++ [h]
       #z = append(rev(t), h)
     end


     def nth_l(1, [r|_]) do r end
     def nth_l(2, [_,r|_]) do r end

     #queues
     def add({:queue, front back}, elem) do
       {:queue, front , [elem | back]}
     end
     def remove({:queue, [elem | rest], back}) do
       {:ok, elem, {:queue, rest, back}}
     end
     def remove({:queue, [], back}) do
       case rev(back) do
         [] ->
           :fail
         [elem | rest] ->
           {:ok, elem, [queue, rest, []]}
       end
     end

     #tree
     #{:leaf, value}
     #{:node, key, value, left, right}
     #def member (_, :nil) do :no end
     #def member(n , {:leaf, n}) do :yes end
     #def member(_, {:leaf, ...}) do :no end
     #def member(n, {:node, ..., ..., ...,}) do :yes end
    # def member(n, {:node,  _, left, right}) do
     #    case ... do
      #     :yes -> :yes
       #    :no -> #case do member(left) yes / no do member(right)
        # end
    # end

     #if tree is ordered
     #def member (_, :nil) do :no end
     #def member(n , {:leaf, n}) do :yes end
     #def member(_, {:leaf, ...}) do :no end
     #def member(n, {:node, ..., ..., ...,}) do :yes end
     #def member(n, {:node,  v, left, right}) do
      #   if n < v do
       #    ... #go left
        # else
         #  ... #go right
        # end
    # end

     #def lookup(key, :nil) do ... end
     #def lookup(key, {:node, key, ..., ..., ...}) do ... end
     #def lookup(key, {:node, k, _, left, right}) do .. end


     def test do
       a = [1, 2, 3];
       b = [4, 5];
       c = tailr(a, b)
       d = rev(a)
       IO.inspect(c)
       IO.inspect(d)
       :ok
     end
end
