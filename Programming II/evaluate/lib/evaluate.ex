defmodule Evaluate do
  #From EnvList:
    #def add(map, key, value)
    #def lookup(map, key) do member(map, key) end



  def add({:num, a}, {:num, b}) do {:num, (a + b)} end
  def sub({:num, a}, {:num, b}) do {:num, (a - b)} end
  def mul({:num, a}, {:num, b}) do {:num, (a * b)} end
  def division({:num, a}, {:num, b}) do {:num, (a / b)} end




  #1. given number return number
  #2. given variable, return corresponding number found in environment
  #3.
  #4. turn :var into :num if there are any then add
  #5. turn both into :num then sub
  #6. turn both into :num then mul
  #7. turn both into :num then div
  def eval({:num, n}, _) do {:num, n} end
  def eval({:var, a}, env) do {:num, EnvList.lookup(env, a)} end

  def eval({:q, n, m}, env) do division(eval(n, env), eval(m, env)) end

  def eval({:add, a, b}, env) do add(eval(a, env), eval(b, env)) end
  def eval({:sub, a, b}, env) do sub(eval(a, env), eval(b, env)) end
  def eval({:mul, a, b}, env) do mul(eval(a, env), eval(b, env)) end
  def eval({:div, a, b}, env) do division(eval(a, env), eval(b, env)) end



  def test() do

    env = EnvList.new()
    env = EnvList.add(env, :x, 2)

    #eval({:add, {:q, {:num, 5}, {:var, :x}}, {:num, 1}}, env)
  

  end
end
