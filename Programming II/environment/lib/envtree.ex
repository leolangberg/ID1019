defmodule EnvTree do

  #tree
  #{:leaf, value}
  #{:node, key, value, left, right}

  def new do nil end

  #1. adding a key-value pair to an empty tree
  #2. if the key is found we replace it
  #3. return a tree that looks like the one we have but where the left branch has been updated
  #4. same thing but instead update the right branch
  def add(nil, key, value) do {:node, key, value, nil, nil} end
  def add({:node, key, _, left, right}, key, value) do {:node, key, value, left, right} end
  def add({:node, k, v, left, right}, key, value) when key < k do {:node, k, v, add(left, key, value), right} end
  def add({:node, k, v, left, right}, key, value) when key >= k do {:node, k, v, left, add(right, key, value)} end

  #1. lookup on empty map.
  #2. if key is found return value.
  #3. if key < k do lookup on left node.
  #4. if key >= k do lookup on right node,
  def lookup(nil, key) do nil end
  def lookup({:node, key, value, left, right}, key) do value end
  def lookup({:node, k, v, left, right}, key) when key < k do lookup(left, key) end
  def lookup({:node, k, v, left, right}, key) when key >= k do lookup(right, key) end

  #1. remove on empty map
  #2. if correct node does not have left branch give right
  #3. if correct node does not have right branch give left
  #4. correct node has both branches then take the leftmost(right) node and replace, then remove old spot of replacement
  #5. if key < k go down left
  #6. if key >= k go down right
  def remove(nil, _) do nil end
  def remove({:node, key, _, nil, right}, key) do right end
  def remove({:node, key, _, left, nil}, key) do left end
  def remove({:node, key, _, left, right}, key) do
    {:node, new_key, v, _, _} = leftmost(right)
    {:node, new_key, v, left, remove(right, new_key)}
  end
  def remove({:node, k, v, left, right}, key) when key < k do {:node, k, v, remove(left, key), right} end
  def remove({:node, k, v, left, right}, key) when key >= k do {:node, k, v, left, remove(right, key)} end


  #1. basecase (lowest possible left node)
  #2. walks down left until basecase is found
  def leftmost({:node, key, value, nil, rest}) do {:node, key, value, nil, rest} end
  def leftmost({:node, key, value, left, right}) do leftmost(left) end

  def test do
    map = new()
    cur = add(map, :f, 6)
    cur2 = add(cur, :d, 4)
    #cur3 = add(cur2, :b, 2)
    #cur4 = add(cur3, :e, 5)
    #cur5 = add(cur4, :a, 1)
    #cur6 = add(cur5, :c, 3)

    #remove(cur6, :b)

  end
end
