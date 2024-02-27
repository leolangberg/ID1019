defmodule Cmplx do

  def new(r,i) do {r,i} end

  def add({r1, i1}, {r2, i2}) do {r1+r2, i1+i2} end

  def sqr({r, i}) do {r*r - i*i, 2*r*i} end

  def absolute({r,i}) do
    :math.sqrt(r*r + i*i)
  end


  def test do
    number = new(4,3)
    number = absolute(number)
    :math.sqrt(9)
  end
end
