defmodule MapReduce do

  def map([], _) do [] end
  def map([h | t], op) do [op.(h) | map(t, op)] end


  def reducel([], b, _) do b end #reduce left (on way down)
  def reducel([h | t], b, op) do reducel(t, op.(h, b), op) end
  # b = op.(h,b) on every iteration so b once it reaches basecase will be
  # the total sum

  def reducer([], b, _) do b end #reduce right (tail recursive)
  def reducer([h | t], b, op) do op.(h, reducer(t, b, op)) end
  #acc = b stands for accumulator

  def filterr([], _) do [] end
  def filterr([h | t], op) do
    if op.(h) == true do
      [h | filterr(t, op)]
    else
      filterr(t, op)
    end
  end

  def filterl(list, op) do filterl(list, op, []) end
  def filterl([], _, acc) do Enum.reverse(acc) end
  def filterl([h | t], op, acc) do
    if op.(h) == true do
      filterl(t, op, [h | acc])
    else
      filterl(t, op, acc)
    end
  end

  def filterreverse(list, op) do filterreverse(list, op, []) end
  def filterreverse([], _, acc) do acc end
  def filterreverse([h | t], op, acc) do
    if op.(h) == true do
      filterreverse(t, op, [h | acc])
    else
      filterreverse(t, op, acc)
    end
  end




  #function that takes a list of integers and returns the sum of the square of all values less than n.
  def squaresum(list, n) do squaresum(list, 0, fn(x) -> x < n end, fn(h,b)-> h*h + b end) end
  def squaresum([], b, _, _) do b end
  def squaresum([h | t], b, optf, opsum) do
    if optf.(h) == true do
      squaresum(t, opsum.(h,b), optf, opsum)
    else
      squaresum(t, b, optf, opsum)
    end
  end


  #ALL PREVIOUS RECURSIVE FUNCTIONS
  def längd(list) do längd(list, 0, fn(x)-> x + 1 end) end
  def längd([], acc, _) do acc end
  def längd([h | t], acc, op) do längd(t, op.(acc), op) end


  def even(list) do even(list, fn(x)-> rem(x,2) == 0 end) end
  def even([], _) do [] end
  def even([h | t], op) do
    if op.(h) == true do
      [h | even(t, op)]
    else
      even(t, op)
    end
  end

  def odd(list) do odd(list, fn(x)-> rem(x,2) == 0 end) end
  def odd([], _) do [] end
  def odd([h | t], op) do
    if op.(h) == true do
      odd(t, op)
    else
      [h | odd(t, op)]
    end
  end

  def sum(list) do sum(list, 0, fn(x, acc) -> x + acc end) end
  def sum([], acc, _) do acc end
  def sum([h | t], acc, op) do sum(t, op.(h,acc), op) end

  def inc(list, n) do inc(list, n, fn(x) -> x + n end) end
  def inc([], _, _) do [] end
  def inc([h | t], n, op) do [ op.(h) | inc(t, n, op)] end

  def dec(list, n) do dec(list, n, fn(x) -> x - n end) end
  def dec([], _, _) do [] end
  def dec([h | t], n, op) do [ op.(h) | dec(t,n,op)] end

  def mul(list, n) do mul(list, n, fn(x) -> x * n end) end
  def mul([], _, _) do [] end
  def mul([h | t], n, op) do [ op.(h) | inc(t, n, op)] end

  def remainder(list, n) do remainder(list, n, fn(x) -> rem(x,n) end) end
  def remainder([], _, _) do [] end
  def remainder([h | t], n, op) do [op.(h) | remainder(t, n, op)] end

  def prod(list) do prod(list, 1, fn(x, acc) -> x * acc end) end
  def prod([], acc, _) do acc end
  def prod([h | t], acc, op) do prod(t, op.(h, acc), op) end

  def division(list, n) do division(list, n, fn(x) -> rem(x,n) == 0 end) end
  def division([], _, _) do [] end
  def division([h | t], n, op) do
    if op.(h) == true do
      [h | division(t, n, op)]
    else
      division(t, n, op)
    end
  end









  def test do
    map([1,2,3], fn(x) -> x * 2 end)

    reducel([1,2,3], 0, fn(h,b) -> h + b end)
    reducer([1,2,3], 0, fn(h,b) -> h + b end)

    filterl([1,5 ,3, 4, 2], fn(x)-> x > 2 end)
    #filterr([1,5,3,4,2], fn(x)-> x > 2 end)
    #filterreverse([3,2,7,4,5], fn(x) -> x > 2 end)


    #squaresum([1,2,3],0, fn(x)-> x < 3 end, fn(h,b)-> h*h + b end)
    #squaresum([1,2,3], 3)

   # dec([1,2,3], 1)
    mul([1,2,3], 2)
    remainder([1,2,3], 2)
    prod([1,2,3,4])
    division([1,2,3,4], 2)
  end
end
