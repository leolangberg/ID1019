defmodule Derivative do

  #base expressions
  @type literal() :: {:num, number()} | {:var, atom()}
  @type expr() :: literal()
    | {:add, expr(), expr()}
    | {:sub, expr(), expr()}
    | {:mul, expr(), expr()}
    | {:div, expr(), expr()}
    | {:exp, expr(), expr()}
    | {:ln, expr()}
    | {:sqrt, expr()}
    | {:sin, expr()}
    | {:cos, expr()}

  @type error() :: {:error, string()}

  #COMPILER TEST
    def test do
      a = {:add, {:mul, {:var, 2}, {:var, :x}}, {:num, 4}}
      #c = deriv(a, :x)
      b = {:exp, a, {:var, :y}}  #d/dx(2x + 4)^2 --> 2(2x + 4)^1 * (2)
      c = deriv(b, :x)
      #IO.write("expresson: #{pprint(b)}\n")
      IO.write("derivative: #{pprint(c)}\n")
      IO.write("simplified: #{pprint(simplify(c))}\n")
    end

    def test2 do
      a = {:sin, {:mul, {:num, 2}, {:var, :x}}}
      b = {:div, {:num, 1}, a}
      d = deriv(b, :x)
      IO.write("derivative: #{pprint(d)}\n")
      IO.write(pprint(simplify(simplify(d))))
      :ok
    end

    def test3 do
      a = {:div, {:num, 1}, {:var, :x}}
      b = (deriv(a, :x))
      IO.write("#{pprint(simplify(simplify(b)))}")

    end

    def test4 do
      a = {:mul, {:num, 2}, {:sin, {:var, :x}}, {:num, 3}}
      IO.write("#{pprint(simplify(a))}\n")

    end

    def test5 do
      a = {:div, {:add, {:var, :x}, {:num, 2}}, {:var, :x}}
      b = deriv(a, :x)
      IO.write("#{pprint(simplify(b))}\n")
    end

  #DERIVATIVE FUNCTIONS
    def deriv({:num, _}, _) do {:num, 0} end
    def deriv({:var, v}, v) do {:num, 1} end
    def deriv({:var, _}, _) do {:num, 0} end
    def deriv({:add, e1, e2}, v) do   #d/dx(f + g) = df/dx + dg/dx
      {:add, deriv(e1, v), deriv(e2, v)}
    end
    def deriv({:sub, f, g}, v) do     #d/dx(f - g) = df/dx - dg/dx
      {:sub, deriv(f, v), deriv(g, v)}
    end
    def deriv({:mul, e1, e2}, v) do    #d/dx(f * g) = (df/dx * g) + (f * dg/dx)
      {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
    end
    def deriv({:div, f, g}, v) do      #d/dx(f / g) = (df/dx * g) - (f * dg/dx) /(g^2)
      {:div, {:sub, {:mul, deriv(f, v), g}, {:mul, f, deriv(g, v)}}, {:mul, g, g}}
    end
    def deriv({:exp, f, n}, v) do      #d/dx(f^n) = n*f^(n-1)
      {:mul, {:mul, n, {:exp, f, {:sub, n, {:num, 1}}}}, deriv(f, v)}
    end
    def deriv({:ln, f}, v) do          #d/dx(ln(f) = (1/f)*(df/dx))
      {:mul, {:div, {:num, 1}, f}, deriv(f, v)}
    end
    def deriv({:sqrt, f}, v) do       #sqrt(f) = f^(1/2) --> d/dx(f^n)
      exponential = {:exp, f, {:div, {:num, 1}, {:num, 2}}}
      deriv(exponential, v)
    end
    def deriv({:sin, f}, v) do        #d/dx(sin(f)) = cos(f)*(df/dx)
        {:mul, {:cos, f}, deriv(f, v)}
    end






  #TRANSFORMING INTO CLEAR NUMBERS
    def pprint({:num, n}) do "#{n}" end
    def pprint({:var, v}) do "#{v}" end
    def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
    def pprint({:sub, e1, e2}) do "#{pprint(e1)} - #{pprint(e2)}" end

    def pprint({:mul, e1, e2}) do "#{pprint(e1)}*#{pprint(e2)}" end
    def pprint({:div, e1, e2}) do "(#{pprint(e1)})/(#{pprint(e2)})" end
    def pprint({:exp, e1, e2}) do "#{pprint(e1)}^(#{pprint(e2)})" end
    def pprint({:ln, e1})      do "ln(#{pprint(e1)})" end
    def pprint({:sqrt, e1})    do "√(#{pprint(e1)})" end
    def pprint({:sin, e1})     do "sin(#{pprint(e1)})" end
    def pprint({:cos, e1})     do "cos(#{pprint(e1)})" end

    def simplify({:add, e1, e2}) do
      simplify_add(simplify(e1), simplify(e2))
    end

    def simplify({:sub, e1, e2}) do
      simplify_sub(simplify(e1), simplify(e2))
    end

    def simplify({:mul, e1, e2}) do
      simplify_mul(simplify(e1), simplify(e2))
    end

    def simplify({:mul, e1, e2, e3}) do
      IO.write("Hello from my_function\n")
      simplify_mul(simplify(e1), simplify(e2), simplify(e3))
    end

    def simplify({:div, e1, e2}) do
      simplify_div(simplify(e1), simplify(e2))
    end
    def simplify({:exp, e1, e2}) do
        simplify_exp(simplify(e1), simplify(e2))
    end
    def simplify({:ln, e1}) do
      simplify_ln(simplify(e1))
    end
    def simplify({:sqrt, e1}) do
      simplify_sqrt(simplify(e1))
    end
    def simplify({:sin, e1}) do
      simplify_sin(simplify(e1))
    end
    def simplify({:cos, e1}) do
      simplify_cos(simplify(e1))
    end
    def simplify(e) do e end


    def simplify_add({:num, 0}, e2) do e2 end
    def simplify_add(e1, {:num, 0}) do e1 end
    def simplify_add({:num , e1}, {:num, e2}) do {:num, (e1 + e2)} end
    def simplify_add(e1, e2) do {:add, e1, e2} end


    def simplify_sub(e1, {:num, 0}) do e1 end
    def simplify_sub({:num, 0}, e2) do
      IO.write("Hello from my_function\n")
      simplify({:mul, {:num, -1}, e2}) end
    def simplify_sub({:num, e1}, {:num, e2}) do {:num, (e1 - e2)} end
    def simplify_sub(e1, e2) do {:sub, e1, e2} end


    def simplify_mul({:num, 0}, _) do {:num, 0} end
    def simplify_mul(_, {:num, 0}) do {:num, 0} end
    def simplify_mul({:num, 1}, e2) do e2 end
    def simplify_mul(e1, {:num, 1}) do e1 end
    def simplify_mul({:num, -1}, {:num, e1}) do
      IO.write("Hello from my_function\n")
      {:num, -e1} end
    def simplify_mul({:num, -1}, {:var, e1}) do
      IO.write("Hello from my_function\n")
      {:var, -e1} end
    def simplify_mul(e1, e2) when e1 == e2 do {:exp, e1, {:num, 2}} end
    def simplify_mul({:num , e1}, {:num, e2}) do {:num, (e1 * e2)} end
    def simplify_mul(e1, e2) do {:mul, e1, e2} end

    def simplify_mul({:num, e1}, e2, {:num, e3}) do {:mul, {:num, (e1*e3)}, e2} end
    def simplify_mul(e1, e2, e3) do {:mul, {:mul, e1, e2}, e3} end


    def simplify_div(_, {:num, 0}) do {:error, "Cannot divide by 0"} end
    def simplify_div({:num, 0}, _) do {:num, 0} end
    def simplify_div(e1, {:num, 1}) do e1 end
    def simplify_div({:num, e1}, {:num, e2}) do {:num, (e1 / e2)} end
    def simplify_div(e1, e2) do {:div, e1, e2} end

    def simplify_exp(_, {:num, 0}) do {:num, 1} end
    def simplify_exp(e1, {:num, 1}) do e1 end
    def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1, n2)} end
    def simplify_exp(e1, e2) do {:exp, e1, e2} end

    def simplify_ln({:num, 0}) do {:error, "ln(0) not legal"} end
    def simplify_ln({:num, 1}) do {:num, 0} end
    def simplify_ln(e1) do {:ln, e1} end

    def simplify_sqrt({:num, e1}) when e1 < 0 do {:error, "negative root not possible"} end
    def simplify_sqrt({:num, 0}) do {:num, 0} end
    def simplify_sqrt({:num, 1}) do {:num, 1} end
    def simplify_sqrt({:num, e1}) do {:num, :math.sqrt(e1)} end
    def simplify_sqrt(e1) do {:sqrt, e1} end

    def simplify_sin({:sin, 0}) do {:num, 0} end
    def simplify_sin(e1) do {:sin, e1} end

    def simplify_cos({:cos, 0}) do {:num, 1} end
    def simplify_cos(e1) do {:cos, e1} end
end
