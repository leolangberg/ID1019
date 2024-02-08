defmodule EvaluateRational do

  #From EnvList:
    #def add(map, key, value)
    #def lookup(map, key) do member(map, key) end
  def gcd(a, 0) do a end
  def gcd(a, b) do gcd(b, rem(a,b)) end

  def simplify({:q, n, m}) do
    if (rem(n, m) == 0) do
      division({:num, n}, {:num, m})
    else
      gcd = gcd(n, m)
      if gcd != 1 do
        {:q, division({:num, n}, {:num, gcd}), division({:num, m}, {:num, gcd})}
      else
        {:q, n, m}
      end
    end
  end


  def add({:num, a}, {:num, b}) do {:num, (a + b)} end
  def add({:q, n1, m1}, {:q, n2, m2}) do
    lcm = Math.lcm(m1, m2)
    ret = {:q, ((n1 * round(lcm / m1)) + (n2 * round(lcm / m2))), lcm}
    simplify(ret)
  end
  def add({:q, n, m}, {:num, a}) do add({:q, n, m}, {:q, a, 1}) end
  def add({:num, a}, {:q, n, m}) do add({:q, a, 1}, {:q, n, m}) end


  def sub({:num, a}, {:num, b}) do {:num, (a - b)} end
  def sub({:q, n1, m1}, {:q, n2, m2}) do
    lcm = Math.lcm(m1, m2)
    ret = {:q, ((n1 * round(lcm / m1)) - (n2 * round(lcm / m2))), lcm}
    simplify(ret)
  end
  def sub({:q, n, m}, {:num, a}) do sub({:q, n, m}, {:q, a, 1}) end
  def sub({:num, a}, {:q, n, m}) do sub({:q, a, 1}, {:q, n, m}) end


  def mul({:num, a}, {:num, b}) do {:num, (a * b)} end
  def mul({:q, n1, m1}, {:q, n2, m2}) do
    ret = {:q, (n1 * n2), (m1 * m2)}
    simplify(ret)
  end
  def mul({:q, n, m}, {:num, a}) do mul({:q, n, m}, {:q, a, 1}) end
  def mul({:num, a}, {:q, n, m}) do mul({:q, a, 1}, {:q, n, m}) end


  def division({:num, a}, {:num, b}) do {:num, round(a / b)} end
  def division({:q, n1, m1}, {:q, n2, m2}) do
    ret = {:q, (n1 * m2), (m1 * n2)}
    simplify(ret)
  end
  def division({:q, n, m}, {:num, a}) do division({:q, n, m}, {:q, a, 1}) end
  def division({:num, a}, {:q, n, m}) do division({:q, a, 1}, {:q, n, m}) end



  #1. given number return rational version
  #2. look for variable, then again eval if it is :num, :var or q;
  #3. given a rational number do nothing
  #4. turn :var into :num if there are any then add
  #5. turn both into :num then sub
  #6. turn both into :num then mul
  #7. turn both into :num then div
  def eval({:num, n}, _) do {:num, n} end
  def eval({:var, a}, env) do eval(EnvList.lookup(env, a), env) end
  def eval({:q, n, m}, _) do {:q, n, m} end
  def eval({:add, a, b}, env) do add(eval(a, env), eval(b, env)) end
  def eval({:sub, a, b}, env) do sub(eval(a, env), eval(b, env)) end
  def eval({:mul, a, b}, env) do mul(eval(a, env), eval(b, env)) end
  def eval({:div, a, b}, env) do division(eval(a, env), eval(b, env)) end




  def test() do

    env = EnvList.new()
    env = EnvList.add(env, :x, {:num, 4})

    #eval({:add, {:q, {:num, 5}, {:var, :x}}, {:num, 1}}, env) (not okay syntax)
    #eval({:div, {:q, 1, 2}, {:var, :x}}, env)
   # eval({:mul, {:add, {:num, 2}, {:var, :x}}, {:num, 2}}, env)
    eval({:add, {:q, 1, 2}, {:q, 6, 4}}, env)

  end
end
