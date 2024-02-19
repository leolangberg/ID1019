defmodule DynamicProgramming do
  def hingetest(material, time) do
    mem = Memory.new()
    {answer, _} = search(material, time, {260, 40, 30}, {180, 60, 24}, mem)
    answer
  end
  #depth of tree ( n / k )  --> O(n)

  #def search([:unk | rest], [n | spec])
  #{[:op, :dam, :unk, :op, :op, :dam], [2, 1]}
  #def serach([:op | rest], spec) do search(rest, spec) end
  #def search([:dam | rest], [n | spec]) do
    #case damaged(rest, n-1) do
      #{:ok, {rest, spec}} ->
        #search(rest, spec) + k
      #:nil ->
        #:0

  def check(m, t, {hm, ht, hp}, {lm, lt, lp}, mem) do
    case Memory.lookup({m,t}, mem) do
      nil ->
        {answer, updated} = search(m, t, {hm, ht, hp}, {lm, lt, lp}, mem)
        {answer, Memory.store({m,t}, answer, updated)}
      answer ->
        {answer, mem}
    end
  end

  def search(m, t, {hm, ht, hp}, {lm, lt, lp}, mem) when (m >= hm and m >= lm and t >= ht and t >= lt) do
    {{h1, l1, p1}, updated} = check(m - hm, t - ht, {hm, ht, hp}, {lm, lt, lp}, mem)
    {{h2, l2, p2}, further} = check(m - lm, t - lt, {hm, ht, hp}, {lm, lt, lp}, updated)

    if (p1 + hp) > (p2 + lp) do
      {{h1 + 1, l1, (p1 + hp)}, further}
    else
      {{h2, l2 + 1, (p2 + lp)}, further}
    end
  end
  # {antal_hinges, antalet_latches, profit}
  def search(m, t, {hm, ht, hp}, {lm, lt, lp}, mem) when (m >= hm and t >= ht) do
    {{h1, l1, p1}, updated} = check(m - hm, t - ht, {hm, ht, hp}, {lm, lt, lp}, mem)
    {{h1 + 1, l1, (p1 + hp)}, updated}
  end

  def search(m, t, {hm, ht, hp}, {lm, lt, lp}, mem) when (m >= lm and t >= lt) do
    {{h2, l2, p2}, updated} = check(m - lm, t - lt, {hm, ht, hp}, {lm, lt, lp}, mem)
    {{h2, l2 + 1, (p2 + lp)}, updated}
  end

  def search(_, _, _, _, mem) do
    {{0, 0, 0}, mem}
  end






end
