defmodule MorseProf do

  def encode(text) do
    table = encode_table(MorseCode.tree())
  end

  def encode_table(tree) do encode_table(tree, [], %{}) end
  def encode_table(:nil, _, table) do table end
  def encode_table({:node, :na, long, short}, code, table) do
    table = encode_table(long,  [45 | code], table) #long -
    table = encode_table(short, [46 | code], table) #short -
  end
  def encode_table({:node, char, long, short}, code, table) do
    table = Map.put(table, char, Enum.reverse(code))
  end
end
