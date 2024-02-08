defmodule Rec do


  def bar(x,y) do x end

  def foo() do
    f = fn(x,y,g) ->
      case x do
        [] -> y
        [h | t] -> [h | g.(t,y,g)]
      end
    end
    fn(x,y) -> f.(x,y,f) end
  end

end
