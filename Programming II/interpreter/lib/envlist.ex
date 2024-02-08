defmodule EnvList do

  #Helper functions
  def append([], y) do [y] end
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
  def member([{key, value} | _], key) do {key, value} end
  def member([_ | t], key) do member(t, key) end




  def remove([], _) do [] end
  def remove([{key, _} | t], key) do t end
  def remove([ h | t ], key ) do [ h | remove(t, key)] end

  def remove_all(map, []) do map end
  def remove_all(map, [key | rest]) do
    map = remove(map, key)
    remove_all(map, rest)
  end



  #when does it return :error?
  def closure([], env) do env end #list of variables, environment
  def closure([h | t], env) do
    IO.inspect([h | t])
    IO.inspect(env)
    case member2(env, h) do #make sure variable not already exist
      nil -> #if not exist then add to environment
        env = append(env, h)
        closure(t, env)
      :error -> #if exist throw error
        :error
    end
  end

  def member2([], _) do nil end
  def member2([key | t], key) do :error end #variable found
  def member2([h | t], key) do member2(t, key) end



  #env = EnvList.args(par, strs, closure)
  #match parameters with expressions and put in end
  #not equal amount of params/exprs

  #def args(par, strs, closure)   #map param [:y] to strs [:b]
  def args([], [], env) do env end
  def args([hp | par], [hs | strs], env) do
    env = add(env, hp, hs)
    args(par, strs, env)
  end



  def test do

   par = new()
   par = append(par, :x)
   par = append(par, :y)

   strs = new()
   strs = append(strs, :c)
   strs = append(strs, :d)

   env = new()

   args(par, strs, env)




  end
end
