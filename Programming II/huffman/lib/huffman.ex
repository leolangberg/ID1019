defmodule Huffman do

  def read(file) do
    text = File.read!(file)
    #text2 = twox(first, first)
    #text4 = twox(text2, text2)
    #text = twox(text4, first)
    #text = twox(text6, text2)
    chars = String.to_charlist(text)
    {:ok, chars, String.length(text), Kernel.byte_size(text)}
  end

  def sample do
    "the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off"
  end

  def text() do
    {:ok, chars, l, s} = read("lib/kallocain.txt")
    {chars, l, s}
  end

  def twox(str1, str2) do str1 <> str2 end

  def test() do
      #tree = tree()
      #encode = encode_table(tree)
      #seq = encode(chars, encode)

      #d = decode(seq, tree)
      #List.to_string(d)

      sample = sample()
      tree = tree(String.to_charlist(sample))
      #IO.puts("Tree built")
      encode = encode_table(tree)
      #IO.puts("encoded table")
      #decode = decode_table(encode)
      #IO.puts("decoded table")
      #text = sample()

      #seq = encode(String.to_charlist(text), encode)
      #IO.puts("encode seq")
      #decode(seq, tree)
      #d = baddecode(seq, decode)
      #List.to_string(d)

  end

  #def bench do
  #  {chars, l, s} = text()
  #  {time, _} = :timer.tc(fn() -> test(chars) end)
  #  {time, l, s}
  #end

  def tree(sample) do
    freq = freq(sample)
    #IO.puts("freq: #{inspect(freq)}")
    huffman(freq)
    build_tree(freq) #join with huffman
  end


  def encode_table(tree) do encode_table(tree, [], %{}) end
  def encode_table({zero, one}, path, table) do
    table = encode_table(zero, [0 | path], table)
    table = encode_table(one, [1 | path], table)
  end
  def encode_table(char, path, table) do
    Map.put(table, char, Enum.reverse(path))
  end


  def decode_table(etable) do
    #etable = Map.to_list(etable)
    #IO.inspect(etable)
    Enum.reduce(Map.to_list(etable), %{}, fn({char, seq}, acc) -> Map.put(acc, seq, char) end)
  end

  def encode([], _) do [] end
  def encode([char | rest], table) do
    case Map.get(table, char) do
      :nil ->
        #:io.format("failed: ~w\n", [char])
        encode(rest, table)
      seq ->
        seq ++ encode(rest, table)
    end
  end


  #braindead
  def baddecode(encoded, dtable) do baddecode(encoded, 1, dtable) end
  def baddecode([], _, _) do [] end
  def baddecode( encoded, n, dtable) do
    {seq, rest} = Enum.split(encoded, n)
    case Map.get(dtable, seq) do
      :nil ->
        baddecode(encoded, n+1, dtable)
      char->
        [char | baddecode(rest, 1, dtable)]
    end
  end


  def decode(encoded, tree) do decode(encoded, tree, tree) end

  def decode([], char, _) do [char] end
  def decode([0 | rest], {zero, one}, tree) do decode(rest, zero, tree) end
  def decode([1 | rest], {zero, one}, tree) do decode(rest, one, tree) end
  def decode(encoded, char, tree) do [ char | decode(encoded, tree, tree)] end


  #Goober storage
  #would be simpler using hash-table
  def freq(sample) do
    charlist = sample#String.to_charlist(sample)
    map = EnvList.new()
    freq(charlist, map)
  end

  def freq([], map) do map end #basecase
  def freq([char | rest], map) do
    newmap =
    case EnvList.lookup(map, char) do
      nil ->
        EnvList.add(map, char, 1) #char with frequency of 1
      {key, value} ->
        EnvList.add(map, key, value+1)
    end
    freq(rest, newmap)
  end


  def huffman(freq) do
    ordered = EnvList.new()
    huffman(freq, ordered)
  end
  def huffman([], ordered) do ordered end
  def huffman(freq, ordered) do
    {key, value} = EnvList.lowest(freq)
    #IO.puts(" key #{key}  value #{value}")
    freq = EnvList.remove(freq, key)
    ordered = EnvList.add(ordered, key, value)
    huffman(freq, ordered)
  end

  def encode_tree(freq) do
    #sorted = Enum.sort(freq, fn(a,b) -> elem(a,1) < elem(b,1) end)
    build_tree(freq) #sorted

  end

  #Professor build-tree
  #def build_tree([{tree, _}]), do: tree
  #def build_tree([{a, af}, {b, bf} | rest]) do
  #  build_tree(insert({{a, b}, af + bf}, rest))
  #end

  def build_tree([{node, _}]) do node end
  def build_tree([{tree1, f1}, {tree2, f2} | rest]) do
    build_tree(insert({{tree1, tree2}, f1+f2}, rest))
  end

  def insert(node, []) do [node] end
  def insert(node1, [node2 | rest]=sorted) do
    if(elem(node1,1) <= elem(node2, 1)) do
      [node1 | sorted]
    else
      [node2 | insert(node1, rest)]
    end
  end


end
