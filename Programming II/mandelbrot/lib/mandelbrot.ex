defmodule Mandelbrot do

  def test(i, z0, c, i=m) do 0 end
  def test(i, z0, c, m) do
    if Cmplx.absolute(z0) > 2 do
      i
    else
       test(i+1, Cmplx.add(Cmplx.sqr(z0),c), c, m)
    end
  end

  def mandelbrot(c, m) do
    z0 = Cmplx.new(0,0) #{r,i}
    i = 0
    test(i, z0, c, m)
  end
  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new((x + k*(w - 1)), (y - k*(h - 1)))
    end
    rows(width, height, trans, depth, [])
  end


  def row(0, _, _, _, acc) do acc end
  def row(width, height, trans, depth, acc) do
    pos = trans.(width, height)
    i = mandelbrot(pos, depth)
    #IO.puts(" i =  #{i} depth: #{depth}")
    pixel = Color.convert(i, depth)
    acc = [pixel | acc]
    row(width-1, height, trans, depth, acc)
  end

  def rows(_, 0, _, _, acc) do acc end
  def rows(width, height, trans, depth, acc) do
    acc = [ row(width, height, trans, depth, []) | acc]
    rows(width, height-1, trans, depth, acc)
  end


  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 32
    k = (xn - x0) / width
    image = Mandelbrot.mandelbrot(width, height, x0, y0, k, depth)
    #IO.puts(" image: #{image} ")
    PPM.write("small.ppm", image)
  end

end
