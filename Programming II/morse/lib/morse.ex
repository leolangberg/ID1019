defmodule Morse do

  #{:node, character, long, short}

  def decode(signal,tree) do decode(signal, tree, tree) end

  def decode([], tree, tree) do [] end
  def decode([], {:node, character, long, short}, _) do [character] end
  def decode([45 | t], {:node, character, long, short} ,tree) do decode(t, long, tree) end  #long -
  def decode([46 | t], {:node, character, long, short}, tree) do decode(t, short, tree) end #short -
  def decode([32 | t], {:node, character, long, short}, tree) do [ character | decode(t, tree, tree)] end #space " " char

  def test() do
    decode(MorseCode.rolled(), MorseCode.tree())
    decode(MorseCode.base(), MorseCode.tree())
    #
    table = encode(MorseCode.tree())
    s = enc('sos', table)
    decode(s, MorseCode.tree())
  end

  #MorseCode.base():   ~c"all your base are belong to us"
  #MorseCode.rolled(); ~c"https://www.youtube.com/watch?v=d%51w4w9%57g%58c%51"

  def encode(tree) do encode(tree, [], %{}) end

  def encode(nil, path, map) do map end
  def encode({:node, :na, long, short}, path, map ) do
    map = encode(long,  [45 | path], map) #long -
    map = encode(short, [46 | path], map)
  end
  def encode({:node, character, long, short}, path, map) do
    new_map = Map.put(map, character, Enum.reverse(path))  #char and Enum can swap places here depending on purpose
    #Needs to move on to next
    new_map = encode(long, [45 | path], new_map)
    new_map = encode(short,[46 | path], new_map)
  end

  def enc([], _) do [] end
  def enc([char | rest], table) do
    Map.get(table, char) ++ [?\s] ++ enc(rest, table)
  end

end
