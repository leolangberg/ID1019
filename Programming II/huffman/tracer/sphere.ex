defmodule Sphere do 

  defstruct(pos: {0,0,0}, r: 2)
  
  # k = c - o
  # a = i*k
  # ||k||^2 = a^2 + h^2 (pytagoras)
  # r^2 = h^2 + t^2
  # t^2 = a^2 - ||k||^2 + r^2 
  # i = o + dI
  # d = a + t 
  # if d < 0 then i is behind the origin o

  defimpl Object do 
    def intersect(sphere, ray) do Sphere.intersect(sphere, ray) end

    def normal(sphere, _, pos) do Vector.normalize(Vector.sub(pos, sphere.pos)) end



  end
end
