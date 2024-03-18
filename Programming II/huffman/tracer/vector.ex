defmodule Vector do

  def smul({x,y,z}, s) do {x*s, y*s, z*s} end

  def add({x1, y1, z1}, {x2, y2, z2}) do {x1+x2, y1+y2, z1+z2} end

  def sub({x1, y1, z1}, {x2, y2, z2}) do {x1-x2, y1-y2, z1-z2} end

  def dot({x1, y1, z1}, {x2, y2, z2}) do (x1 * x2) + (y1 * y2) + (z1 * z2) end

  def scale(x, l) do 
    n = norm(x)
    smul(x, l / n)
  end

  def norm({x, y, z}) do :math.sqrt(x*x + y*y + z*z) end

  def normalize(x) do scale(x, 1) end

  def cross({x1, y1, z1}, {x2, y2, z2}) do {(y1*z2 - z1*y2), (x2*z1 - z2*x1), (x1*y2 - y1*x2)} end

end
