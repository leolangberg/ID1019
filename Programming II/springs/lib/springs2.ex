defmodule Springs2 do

  def parse_rows([]) do [] end
  def parse_rows([h | t]) do [ parse(h) | parse_rows(t)] end

  def parse(row) do
    row = String.trim(row)
    [springs, damaged_sizes] = String.split(row, " ")
    damaged_sizes = parse_damaged_sizes(damaged_sizes)
    springs = String.to_charlist(springs)
    {springs, damaged_sizes}

  end

  def parse_damaged_sizes(str) do
    str = String.split(str, ",")
    str = Enum.map(str, fn(x) -> {nr, _} = Integer.parse(x); nr end)
  end




  def test do

    sample = String.split(sample2(), "\n")
    sample = parse_rows(sample)
    mem = Memory.new()
    sample = springs(sample, mem)
  #  total = sum(sample)

  end

  def sum([]) do 0 end
  def sum([h | t]) do h + sum(t) end







  def springs([], _) do [] end
  def springs([h | t], mem) do
   # IO.inspect(h)
    [ check(h) | springs(t,mem)]
  end

  def check({chars, nums}) do
    {n, _} = check(chars, nums, Memory.new())
    n
  end

  def check(chars, nums, mem) do #chars = [char | t]
    #IO.puts("CHECK")
    case Memory.lookup({chars, nums}, mem) do
      nil ->
        IO.puts("LOOKUP NOT FOUND #{inspect(chars)} #{inspect(nums)} #{inspect(mem)}")
        {answer, updated} = search(chars, nums, mem)
        IO.puts("RETURN #{inspect(answer)} #{inspect(updated)} ")
        {answer, Memory.store({chars, nums}, answer, updated)}
      answer ->
        IO.write("FOUND\n")
        {answer, mem}
    end
  end


  def search({chars, nums}, mem) do
    IO.puts("START #{inspect(chars)} #{inspect(nums)} #{inspect(mem)}")
    search(chars, nums, mem)
  end

  def search([],[], mem) do
    IO.puts("BASECASE #{inspect(mem)} ")
    {1, mem}
  end
  def search([], nums, mem) do {0, mem} end
  def search([chars | t], [], mem) do
   case chars do
      ?# -> {0, mem}
       _ -> search(t, [], mem)
    end
  end

  def search([char | t1],[num | t2], mem) do
    IO.puts("MAINSEARCH #{inspect([char | t1])} #{inspect([num | t2])}, #{inspect(mem)}")
    case char do
      ?# ->
        case damaged(t1, num-1) do
          {:ok, rest} ->
            check(rest, t2, mem)
          :error ->
            {0, mem}
        end
      ?. ->
        check(t1, [num | t2], mem)
      ?? ->
      {answer, updated} = search([?# | t1], [num | t2], mem)
      {answer2, further} = search([?. | t1], [num | t2], updated)
      IO.puts(" ANSWER MEM  #{inspect(answer)} + #{inspect(answer2)} #{inspect(further)} ")
      {answer + answer2, further}
    end
  end

  def damaged([], 0) do {:ok, []} end
  def damaged([nextchar | rest], 0) do
    if nextchar != ?# do
     {:ok, rest}
    else
      :error
    end
  end
  def damaged([?# | t], num) do damaged(t, num-1) end
  def damaged([?? | t], num) do damaged(t, num-1) end
  def damaged(_, num) do :error end



















  def sample2() do
    "???.### 1,1,3"

  end
  def sample do

    "???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1"

  end

  def puzzle do
    "#??#???.??#?#?#??#?. 6,8,2
    ?????????#?#.#?.?.# 4,3,1,1,1
    .???#?#????..????. 1,4,1,1,2,1
    ??????#?.?. 3,2,1
    ?.?????#???#???#?? 3,1,2,5
    ????##???????? 2,4,2
    ?#?#?#??.?? 6,1
    .??#????##?##???..?. 2,9,1
    .???????#????#??#? 2,3,5
    .?#??????##? 7,3
    ?????.???# 1,1,4
    ???#?#??##??#?#??#.# 8,1,4,1
    #????#????#? 1,2,5
    ###.?##?.?#??. 3,3,4
    ??#?.??##? 1,3
    .?#???.??????###.??? 4,1,1,3,2
    ??#?.?#?????.? 3,6
    ?##?#???.?????? 4,1,1,2,1
    ?????#????##??.# 1,9,1
    .????#????###?..?. 8,4,1
    ##??#????? 2,1,3
    .????.?#?#?#?##?? 1,8
    ?.?#?.?#????#???.? 1,2,1,4,2
    .?#?#?#?.#??#???##? 1,4,5,2
    ??????#????? 4,1,1,1
    ???#?????? 1,1,5
    ??????????. 1,1,3
    ?#.???????#? 1,7
    ?????#???### 1,1,2,4
    ??.?#???#. 2,3,1
    ??..?.??#?.#? 1,4,2
    ??.????????. 1,4,1
    .??#.??????#?.?#?? 1,1,1,1,2,3
    ?.?#..???. 1,1
    ???#?????????. 4,2
    #?????.?????? 1,2,1,2
    ?#???????..# 2,2,1,1
    ?#.?#??#?????? 1,5,1,1
    .#..?#????#??#? 1,4,5
    ?..???..?#?#?#?.? 2,6
    ???.?????#??#?. 1,1,6
    ?#?.#???????.? 1,6,1
    .?#??#???##?#? 9,1
    .##??#??.##??? 2,1,2,1
    .????.?#?# 1,1,3
    #??#..??#???.?##?. 4,1,1,1,2
    ..#?#????#? 3,3
    ?#..##?.??##??#. 1,3,3,2
    ??.????.???? 2,1,2
    ????#?????.?. 3,1
    ?#?##???#.?##? 8,2
    ????#.????.???#?? 2,2,1,1,5
    ..?.?.???? 1,3
    ?.??????????# 2,4
    ?.?.?..?##?? 1,1,3
    ????#????.?? 2,2,1,1
    ?.#????.##???#??#.? 1,1,1,3,5,1
    ?????##??#????? 7,1
    ?.???#..?#?.? 1,2,2
    ?#??##???#?.? 5,1
    ???#..?.#?#?##??# 1,1,1,7,1
    ??????#???.?#.??? 1,4,2,2
    ##??????#.??#? 4,3,3
    .?.??#???.? 1,5
    ??#?.???#?? 1,3
    ???????..??? 1,2,1,2
    #????.?#?#???##?? 1,2,3,5
    ?????????.? 1,2,1
    ..#?????.?# 4,1
    #???.?##?## 2,1,5
    ???#.???#?. 1,1,2
    ?.?#.?????#?? 1,2,1,3
    ?.??.?#?#?#?#??#.??? 1,1,10,1,1
    ??#????????.??????? 7,3
    .?#??.#???? 4,5
    ??????.??? 1,1,1
    ??##?..???. 3,3
    ?????##.???.?#?.. 3,3,2
    ????.?..???? 3,1,1
    ???????#?#??.#???. 1,7,4
    .??#?????#.?? 1,4,2
    ?????#?#??.?.#?? 8,1,1
    ????#.?.????#???#? 1,1,1,3,1,2
    ?????#..?.???.#??#? 6,1,1,1,2,1
    ??#???#?.?? 2,1
    ??#.????????##??#? 3,2,7,1
    ?.?????#??.? 3,3,1
    .#?????#?#?##?.??? 2,3,1,2,1
    ?#?#??.?##?###???# 1,3,10
    ??.?????.#???.? 1,2,1,1,2
    ??????..?? 5,1
    ??.??.??#??.#? 1,1,3,1
    ??.?.#?.?..?? 1,1
    #.?#??????#.##?.?#. 1,1,1,1,3,2
    #?###??##?##??#??? 5,9
    ???#.??????#.#? 4,5,1,1
    ??.???#####?# 1,8
    ?????????#??????? 2,1,5,1,1
    ?..?#??.?# 3,2
    ??#??.?.??#. 5,1
    ?#????##.???#. 8,2
    ??.?????###?##?????. 2,1,9,3
    #???#?.??#???# 2,2,3,1
    ?????###????#????. 7,1
    ???????.??..?? 1,3,1,1
    ???????????????????? 3,3,1
    #??????.?#?## 6,5
    #??##??.?#???.??? 7,3,2
    #.??##??#??####????. 1,13,1
    ?#.?????.##??. 1,3,3
    #??.??#???.???#????? 3,5,6
    ?.??????.#??.?. 1,2,2,3,1
    .????#???#..?#??# 4,1,5
    ????#?????? 4,2
    ???#????## 4,3
    .#?.???#?.. 1,3
    ??#??#?????#?.?? 5,5
    ?.?.#?#?????????#??. 1,1,1,2,1,8
    ?###.???..?.#???? 3,1,1,1,3
    .#??#??.???#????.# 1,1,5,1,1
    ????...?.?.#??? 1,1,1,4
    ???##???#?#??..?. 2,7,1
    ??#.?.?..?? 3,1,1
    ##?#?#?????#???. 7,1,2,1
    ??????????#?.#? 5,2,2,2
    ????##??##?#??..??? 13,1
    ???#???#???#???#.#?? 1,7,5,1,1
    .??????###.???? 8,1
    ?.##???.?????#??? 2,1,1,5
    .???#??##???????? 1,5,5
    ?????#??.????. 1,2,3
    ????#?#?..???## 1,4,4
    ???#????##?##?##?.. 4,1,9
    ..#??..????? 2,1
    ???#.?????? 2,1
    ???#...#???.?? 2,2,1,2
    ??#??#?????# 3,2,3
    ??#??????.???? 1,2,3
    ???.??.?#?#???#???. 2,2,8,2
    #?????##??????#???. 11,4
    ???#?#????. 1,4,1
    ?##????#?#?.#. 2,1,4,1
    #???#??????#? 8,3
    #???#.?.#?.# 5,1,1,1
    ???????.???? 1,1,1,1
    ??.?????#???? 1,6,2
    ?.?.?.??#???. 1,1,4
    ?????#???????#..???? 1,3,2,2,2,1
    ??#?.????? 1,3
    ???###??..##.?? 1,5,2,1
    ??###?#???#?. 7,2
    ?.?#????#?????? 1,1,1,3,1
    .#?????..? 1,2,1
    ?#?.?#?????????.?? 3,10,1
    .???#???????..????#? 6,5
    ##?.???????? 3,3,3
    .?##???.???###?.??? 3,6,1,1
    .#??????.#?.???? 1,1,2,2,1
    ##?###??????????. 6,3
    ??.???#??#???.#??#.# 2,9,2,1,1
    .??.###???????.#?? 2,7,1,1,1
    ?.##???.?. 4,1
    .#?..?????#?????. 2,2,1,5
    .?????.#??.? 2,1,2,1
    .??.???.??..?## 2,2,2,2
    ??.???####?##?.???? 11,1
    ???.#.?#????.???# 2,1,3,1,1
    ?.??.?#???? 1,2,1
    ??#.?????#????..?#? 2,3,3,1,2
    .?.?#??#????###??. 1,14
    ##??.??#?. 3,1
    .#???..???? 1,1,2
    .???.#?.#...? 2,1,1,1
    ?#??????#??#??#?? 9,5
    .????#??????###.? 1,1,1,1,5
    ???#??.#?? 1,1
    ?#?.?#?.#???#?#? 2,3,2,4
    ?????#?#?????#?? 1,1,1,9
    #?##??#?.#???. 1,5,1,1
    ?????##?????.??? 1,9,3
    ?.??##???#???.?? 1,6,2,1
    ?###???????.. 4,1,3
    #??..???#??# 1,1,4,1
    ??.?..#??#???###?..? 1,1,1,7,1
    ??????.????? 2,4
    ??????.??. 2,1,2
    .#???????????? 3,4,1,1
    .#??..#????? 2,1,3
    .?.??.????##???? 1,5
    ?#?????#?#??# 5,1,1,2
    ?####??.?.??.? 6,1,2,1
    .???#??#?.?.?#????# 4,7
    ...??????#? 1,1,2
    ???#.#??#??? 1,1,1,2
    ?.?#????#??#???.?? 4,5,2
    ..????#???.?#?. 5,2
    ??..??#??????????? 8,1
    ?#??????..?.? 2,4,1
    ??#????.?? 3,2
    ??.?.??????? 1,5
    ?#??????#??###?#?.?? 1,2,9,1
    .???.#????#??#? 3,2,1,1,3
    ????.?#?.??????? 2,4
    ?.#????#??#?? 2,5
    ?.##???#??????#????? 1,6,8,1
    .???.??.?..???? 1,3
    ??????????? 2,3,2
    .??????#?.?#.????.?? 1,6,2,1,1
    ???..?????? 1,4
    ??##?????... 5,3
    .??#?#????.?? 3,4,2
    ??#.???#?????# 2,1,5,1
    #.??##??#?.???? 1,8,1,1
    ?#?#??#?.?#?#??#?.? 7,7
    ??#????????? 3,2
    ?#..#?#????? 2,6
    ??##.##??#??#??.??. 2,6,2,2
    ??.??.?.????? 1,2,1,1
    ????#???????#? 4,2,2
    .?..?#????????????.# 1,4,1,4,1
    ???????#.??? 1,5,1,1
    ????#.#??#???????#? 1,2,2,1,7
    ?.???#.?????? 1,4,1,1
    .??.#????##?? 2,4,2,1
    #????.#?## 4,4
    ???#?.??.???.?#?.?## 3,1,3,1,3
    ??.?#?????????####? 1,3,10
    ?.?#?????#??##??..?? 6,1,2,2
    .???#??#?. 1,3
    .?????###?. 1,1,4
    ??#?.??????#??? 1,1,4,2
    .?#?.????#??? 2,3,3
    ?#???.????#???. 5,3,1,2
    #???#??#???#??#?. 2,3,2,2,3
    ?.??????##???.???? 7,1
    ???#.##??##???# 2,1,3,3,1
    ????#?.?#?#???. 6,6
    .???#????? 4,1,2
    ????#????##?#??? 2,8,1,1
    .??????#?? 1,1,4
    ???..###.?##?##??? 1,3,6,1
    ####????.???.???.? 5,2,2,3
    .??..?????.??.? 1,2,1
    ????..?#.#????? 4,2,6
    ???.?#????##??? 2,7
    ???????.?.#..### 1,2,1,1,3
    #????????????? 3,4,1,2
    ???..#????????#???? 2,11
    .???.????#?? 1,2,1
    .?#?????..???. 6,3
    .??????.????? 1,2,3
    ..???#?#?#?????#??.? 9,4,1,1
    ?##?.??#????#..##?# 2,1,2,3,2,1
    .#?????#??##?? 1,1,4,3
    ?#???#????? 1,1,5
    .?###..??.?#????? 4,1,5
    ????#???.. 1,1,1
    ??#????????..???# 9,3
    .?#.?#.?.?. 2,1,1
    ??#??#?.????????#?? 4,3,3
    #????..???#??.. 5,3
    .?#?.??#?.???#. 1,4,3
    #???#????.? 1,2,2
    .#????.??##?????. 5,5,1
    ?????.???????# 4,1,2
    .?.?###?##???????## 11,3
    ?????#?####???.??##? 1,6,1,3
    ?#.??.#??##?.##??? 2,1,1,3,2
    ..???##.?.? 5,1
    ???.?.???? 2,1,1
    ?.???#?#?.?#.??.# 7,2,1,1
    ?????.??.? 1,2,1
    ???.?.##??#? 1,2,2
    ?.#????##???????.?# 8,1,1,1,2
    .??#.?#???#?? 2,8
    .?#?#?.?????#??#?# 5,1,4,1
    ??##????.#..? 4,1,1,1
    #????.????????????#? 5,2,1,1,2
    ?..#????.???.?.. 4,1
    ?#?.???#???.????? 2,5,1,3
    ??#??#?#??.?#?##?? 2,6,4
    ??#?##?.?????? 5,2
    ?.?.??.?#?? 1,1,4
    ?????.?#??? 2,4
    .????.?#???? 1,1,2,3
    .???????#???? 1,2,2,1
    ??.??#?????? 2,8
    ???.??????? 1,1,2
    ??#??#?##????#.?? 1,4,2,1,1
    ?##?????#??#.?#??#? 3,4,4
    ..???#?.?.#?#?.??.? 1,3
    ??????###???? 1,3,2
    ?????#???.?#?#?##? 1,1,3,1,6
    #????????????.?.?#? 1,1,8,1,1
    ??#????##?#??????.. 1,10,1,1
    ?##?.???.??? 4,1,1,1
    .?.???.#??# 1,1,4
    ?#.???#?#?????..## 1,1,8,2
    ??#??.??#?????# 3,1,1,4
    ?????#?#??? 1,8
    ???.?.????? 2,1,1
    ??#?.#?????.???.??? 1,1,1,3,3,2
    ??????.???#?#????? 1,1,1,6,2,1
    ??#?????#??.????..? 3,2,3
    #.?.??????.??. 1,1,3,1
    ?#?.#????#???#?.???. 1,3,3,2,1,1
    ??##??????.?..? 6,1,1
    ???????#?.#??. 6,3
    ???#.????#??.#? 2,1,1,1,2
    ##???#?#?#?? 2,2,1,2
    ???????..## 2,2
    ??#?..?#??#?#.??? 1,7,2
    ???####?#?#.#???#?? 9,1,5
    .?#?.#.???#?.? 2,1,4
    ????..??#..?. 4,1,1
    ??????????..??? 9,1
    ####?#?#??.???????? 10,1,1,1,1
    #?#??#??#???????.?? 6,1,1,1,1,1
    ??.????????#? 1,1,1,3
    #?..##?.???? 2,2,2
    ??#?????#?????.? 1,5,1,2,1
    .?.?#??###??#??#?# 1,14
    ????????.????.?? 5,3,1
    ???????????#.?? 6,1,1,1,1
    ?.?.???#???. 1,1,2,2
    #??#?????????? 1,1,1,7
    ?????#???# 1,4,2
    ?.??..#??. 1,1,1
    .???#??#????????? 2,1,2,3,1
    ?#??.???#????#? 2,2,1,1,2
    ?###?????.?? 3,2,1,1
    ???????#?.????? 2,4,2,1
    ???..?#???#?.??? 2,1,1,2,2
    #.#???####. 1,8
    ?.???#??????? 1,2,2
    ..#???##??#??#?? 3,5,1
    ?.???#???????#? 4,2,2
    ??##?.#??#??????? 1,3,1,1,5
    ##?#???.??.??#.? 2,1,1,1,1
    ??????#?????# 7,4
    .???#??????##? 5,1,2
    .??????#?##?#?? 2,6
    .#?.??#.#?#??. 2,2,5
    ?..?##?#?????#??#?? 1,15
    ?????????????#???. 1,3,1,1,1,1
    ##?.????????.#?. 2,1,1,1,2
    ?#.???.#.?#??.?.?? 1,1,1,3,1,1
    .#.??.?.?###.???? 1,2,1,3,1
    ???#?????##??.?.??.? 5,4
    ????###?#?##????.? 1,12
    ?#??.?????? 4,2
    ?????#??????.? 8,2,1
    ????????## 2,2,3
    ???#???#?? 2,2,3
    ????#.?.?#?????.???? 1,1,1,5,1,1
    ...????.?.?????#?. 3,4
    ..?..?#??#????#?? 6,1
    .?#??.?????.?##???.? 3,4,5,1
    .?..??#?.#? 1,2,2
    ????##??????.#? 1,8,1
    ???.##?#?.??##?? 1,5,5
    #?????#??????? 1,8,1
    .????#?????? 2,2
    ????##??.#? 1,4,1
    ?#?#?#?.???#?. 7,3
    ???????#??????.????? 10,2
    ????#??.?#.?? 3,2,1
    ???.#.?#?##?????# 1,1,5,3
    ???##.#?##?????.?.# 1,2,1,7,1
    ????.##?#??##??? 2,10
    ?#?.????#??#?##?#?#. 2,12,1
    ????#??#??.??#??? 4,2
    ??.#????#?.??? 2,1,5,1
    .###?.??.?#.#.?.???? 4,1,1,1,1,2
    ??#??###?.#?.????.# 8,2,3,1
    ?##???.?.##??#??.??? 6,1,7,2
    ??###??.????##?#?##? 3,2,8
    #???????#??#?#??#??? 4,4,9
    ??#????????# 2,3,2
    ?#?.?.#?.?.?????# 3,1,2,1,4
    ?#??##?#???.?..?. 7,1,1,1
    ???????#.?????##.?. 8,1,3,1
    ..???##.??# 1,3,1
    .#??#?..####?#. 4,6
    ?????..??????# 5,1,2,1
    ???##?##.????##?# 1,2,2,1,5
    ???.??#???.?. 2,1,3,1
    ???.??###??????#?#? 2,4,6
    ?#???#?#??????? 6,3,3
    ?##..?#???????## 2,10
    ?#??.?.#?.?# 3,1,2,1
    #???.#???. 3,3
    ???.?.#?.#??#?????. 1,1,2,1,3,1
    ?...?.??????? 1,4
    ??.????.#.? 1,3,1
    ????#??.?.###.???? 1,4,3,3
    ?????..???.?? 1,1,2,1
    .??.??##????#?. 2,8
    ??.??#??????. 5,1
    ###??#??.??? 6,3
    ##????##????##..? 2,11,1
    ??.????.??????? 1,2,1,1,2
    .???????????????.?. 5,5
    ??...?????.? 1,1,1,1
    ????###?##? 4,2
    ??##???#?????????? 5,7
    ?????????.?.# 6,1,1,1
    ?????.???? 1,1,3
    ??#??????## 4,4
    ???.?#..?#?##.?.#??? 1,1,5,1,1,1
    .#?.#??????. 2,1,3
    .????.?????##? 1,1,7
    ???.???????. 1,1,3,2
    .???##??..??.#..#? 7,1,1,1
    ??#????#???????????? 15,1
    ##??????..???? 6,1
    #?.???#??? 1,3
    ?##????#???#? 2,6,2
    ###??#???#???????? 6,1,1,2
    .???????.? 1,1,1
    ??????#??..?.##?##? 8,1,5
    .?##?????.?. 6,1
    .#???.????#???# 1,1,1,4,1
    .#??.#?##?#? 3,1,2,2
    #?????????#??##?# 1,3,2,1,5
    ???.??#????? 2,6
    ?.?#??..??## 1,4,1,2
    ..???????????.? 5,1
    ???.#??#.??????#?.? 1,4,8
    ?????.#???#?#?? 3,1,3,1,1
    ???????.?#??##????? 1,3,6,1,1
    ?.##????????###?? 3,3,6
    #??????.##??## 1,1,1,6
    ?#.??.?.?#?. 1,1,1,2
    #???##??##?.?.????#? 2,4,2,1,1,3
    .???????.??# 2,1,3
    ???##?##?#?#????? 11,1
    ???????#?#??. 6,3
    ????#???#?.????#.? 10,1
    ?#?????.?#????#? 4,6
    ?.???.?#.?. 1,1
    .??.#???.?. 1,1,1
    ?#?????????????? 1,1,1,5,1
    ???.?????#? 1,1,4
    ???#????..?? 6,1
    ?.#?????#?????.?. 10,1
    ?.#??.#?.#?.? 2,2,1
    .??#???.?##?.#?. 1,1,1,3,2
    #?#???#?#?????#?#?? 15,1
    ..???##.?????.???#?? 3,4,3
    .??.???????.? 1,4,1,1
    ???#?????.??.?????? 5,1,1,3,1
    .??????.?.??#??? 5,1,3
    ??#?????##???. 1,9,1
    .#???????????.? 1,1,2,2,1
    ??#?.??.??? 3,1
    ???.???.??.???????? 1,2,1,3,3
    ?.##??????#? 1,4,3
    ?#?##???#?#..? 9,1
    ????????.?.???? 7,2
    ??#????#?#?.???? 2,5,3
    .?.??.#??#?????. 1,4,3
    .???#??#?.#.??##?# 8,1,6
    ?..?.??.??????..?..? 1,1
    ??.?.??????? 1,1,1,2
    .?#..????? 1,2,1
    ??#?.????.##???? 2,2,2
    ?????#?##??.???.? 1,6,2
    ??????????????. 4,4,1,1
    ???##..?????##?#??? 4,10
    ??...?##???#?#??? 1,3,6
    .?.#.???#?#?#?? 1,1,1,5
    .?#??##???##??.#?# 12,3
    ?????#.??.?##?????? 3,1,1,4,3
    ??#.#.??#.#??? 3,1,3,3
    #???????????#?? 1,2,1,6
    ???.?????.??.? 3,1,1,1
    ??#???.?????# 3,1,2,1
    ??..????.?..?? 2,2,2
    .#???#??#????#? 11,1
    ???.??.????#??..?## 1,1,1,4,1,2
    ..??##?????.?.?#? 9,1
    ??##?#?#??#???? 1,10
    #?#?????????#. 3,9
    ????#????#?? 5,4
    ?#???#??????????#. 7,2,1,1
    .#??#?????#.?#.??#. 5,4,2,1
    #??.#?.?????.#? 3,1,1,1,1
    .?#??????.??? 3,1,3
    ???.?????#?#???? 1,1,1,3,1
    .#????##?#??.#. 1,3,1,1,1
    ???#?.????#?? 5,2
    #.??##?####?.???? 1,1,8,1,1
    .?.??#??????. 1,4,1
    ??????.?#? 6,1
    ..???.#?##?.???.? 2,5,2
    ??###????????.????? 5,6,2
    ????.????? 2,1,1
    ???.?#???#??#? 1,6,1
    ..#?.???#?.#?#? 2,1,1,1,1
    ??.?###?#????#??. 8,1
    ?###???##??????? 3,8,1
    .#.#??#?#?. 1,2,3
    .???#.?..##?????#??? 4,5,3,1
    ???###??..??? 6,1
    .##?###?????#???#? 6,1,2,2
    #.??????#?? 1,2,3
    .?.#?##??##??????? 8,5
    ??????????# 1,4,1
    .???..???????.? 1,7
    #?##??.#????#.?? 1,3,1,1,1
    ?#?#??.??#? 5,1,2
    ?.?#?#??#??##??. 4,7
    ##?.???????.??????? 2,1,4,5
    ??.?????????..??#?? 1,4,1,1,1,2
    ??..??#???????? 1,2,1,2
    ?.#???#??.?#?#? 1,2,1,1,5
    ??.?????##????.? 2,10,1
    ?.????.#???#??.? 1,3,1,3,1
    ??#??#????..????? 8,1,3
    ?????#?#??#### 1,1,3,5
    ?.??#???????..#??? 1,6,1,3
    ##?#???????.#??? 7,2,4
    ??#?..????#??##??# 4,1,2,2,1
    ??????#??#?.?#?##??. 1,9,2,2,1
    ???#?.????.????? 2,3
    .?.?????.??????.?# 1,1,2,1,2
    .??????##.??? 8,1
    ??#..#????## 1,1,1,2
    ???.??.?#?#?. 1,1,3
    ?????.?????.??? 2,5,1
    .#?#???.????? 5,1
    #???#?#???#?.?.????? 3,8,3
    #?.#?.???.??? 1,1,3,2
    ??#?#?#?#????#.? 9,1,1,1
    .#???#..?????. 3,1,1,1
    ??#.??????#. 1,1,1,1
    ???#?##?.???...??. 1,5,2,2
    ???.?.????#. 1,1,1,3
    ???###?.??#???. 5,5
    ?..?.??#???.???.?..? 4,1
    .??#?.???#??..?# 2,4,2
    ?#????#??#?? 1,1,1,3
    #??????#???#??? 8,1
    ??????#.?.?.?. 1,5,1
    ??.??.?????.#? 1,4,1
    ?#??#?##???#????.# 1,5,3,1
    ????????.#?#???? 3,3,4,1
    ???????????..??????? 1,1,1,1,1,6
    ???#??#?#??##?## 1,1,1,8
    ??????????????? 2,1,1,1,1
    ?..???.?????.#? 1,1,1,1,2
    ??????##?????.?#?.?? 1,8,2
    .?.?#??#???? 1,1,1,1
    .???#?????.? 4,1,1
    ????..?#?? 2,2
    ????#??.#? 5,2
    ????..?.#.? 1,1
    ????????#?? 1,2,1
    ????#?..?.# 3,1,1
    ?##?????#???? 6,2,1
    ????.????####??. 4,1,6
    ??.#?#?#.???????? 2,5,2,1,1
    ?.#??.?#??????????? 1,1,1,3,5,1
    ??..?.??#??? 1,3
    ??.??...?????#?#?? 2,1,9
    ??##?#??#??. 4,4,1
    ??##????#???# 8,2
    .???#?????.. 2,2,3
    ????????.?. 3,1
    ?.???#?????????????? 1,1,4,2,2,1
    .?##???.???????? 3,5
    ??#??...#??#? 4,1,1
    ????#.####. 3,1,4
    .##???.??? 2,1,2
    ??##???????? 1,4,1,1
    .#????#?.?#?#? 1,3,4
    .?????##?#??????? 1,8,1
    .#?.##?.#? 1,3,1
    ?#????.????? 5,2,2
    ??.##?.??#.?????? 3,1,1,6
    ??.????#.?##??#?. 2,1,1,6
    ??.?????.??.? 2,2,1,1
    ?#?#??#????.?#??##.# 10,3,2,1
    ?#??#?..??#????.??? 4,2
    ?#...???#??.? 2,1,3
    #??.??.#???#..??? 3,1,1,1,1
    ??#?????..#??.#?.??? 5,3,2
    #??####?.#????#????? 7,2,1,1,1,1
    ..#??.?.#.???.??? 3,1,3,2
    ....??#?????.??##?.. 7,3
    .???##??.?? 3,1
    #.?#?..?###?#?#? 1,2,5,1
    ???#?.??#????#?? 5,1,1,1,2
    ??##.?#?##??????.?? 1,2,5,1,1,1
    #???#??#????..??# 8,1,1,3
    .?#??..#.?????? 2,1,1,3
    ????????..????? 1,3,1,2
    .?...?#?#?????? 1,9
    .?#?.?????#?????## 1,1,10
    #??..?#?#?.? 2,5
    ??#.???#?.???#??? 1,5,1,2,1
    ??.?.###?##?#?#?#? 1,1,8,1,1
    .?.???#??###.?????? 1,2,6,1,1
    ?????.?#?#?#???? 2,1,6,1
    ???????.#?#????##. 1,1,9
    .?##?.?????? 3,2,1,1
    ????#??#????#????? 2,3,2,2,2
    ?##?##???#?#????#?# 5,1,1,1,1,3
    ?.??#.?#???#????? 1,3,1,6,1
    ?#???#?#.????.?. 1,1,1,3,1
    ?..?#??..# 1,3,1
    ?##?????.#????#? 3,1,1,1,1
    ??#..??##??#? 1,5
    .?.#..???????? 1,1,2,4
    ?.????????.#? 1,1,2,1
    ???####?.?#??? 6,4
    ??????..#?? 2,2
    ?.??????#??.? 1,7,1
    ???#??????. 1,4
    ???.?#????.??.#.?. 2,2,1,2,1,1
    .?##.#?????#??# 3,1,2,2,1
    ????.?#?????????? 1,9
    ?.??#?????.?. 3,1
    #????#.??????. 6,1
    ?.???????.???# 1,2,2,1
    #.?#????????.?? 1,5,1,2,1
    .?.#.?#????#? 1,3,2
    ???#?#..??.# 6,1
    .??????.?????##? 4,2,3
    .???.????#?#..??? 2,4,1
    ?.????...?? 2,1,2
    ???????#??#??#?#?. 2,9
    ?????????#?????.? 1,1,5,4,1
    .????.??#?..#??? 3,3,2
    ??#?#?.?.?###. 5,3
    ????????.#?#???? 1,1,1,1,5
    .##?#?#?.?.???????? 2,1,2,1,7
    ?????###.?.???#? 7,5
    ??.??#.??##???? 1,2,4,1
    #??#?????? 5,2
    ...?.?????.??#. 2,3
    ??#??.??.. 1,3,1
    ?????????.?#??#???.? 3,2,8
    ???#??????#.#?#???? 5,2,1,1,1
    ??#..?##???##?. 1,3,3
    ??.????#?#??????# 1,1,9,1
    ??###????. 1,6
    .??##?##?.??#?#? 8,1,1,1
    ?#..??#???? 1,1,3
    ???##?????#??????.? 3,4,1
    ????#?..?????.?#?.?. 4,4,2
    ?#???.??#???..? 1,2
    .?#??#..???? 4,1
    .?##...??##? 3,1,3
    ????????#???#?#. 2,2,3,2,1
    #???#?#???#?#?#??? 5,1,3,5
    ??#??###?#??.?.?# 10,1,1
    .??#?#??#?#??#? 3,1,2,5
    ?????.?#??????#.???# 2,1,4,1,1,4
    ?.#?#?##???.#?? 1,6,1,3
    ??????#?.??? 1,5
    #??##.?##??? 2,2,3,1
    ?#?##??????##.??? 7,3,1
    ??????#????..??? 10,3
    ##?.????##???#.? 2,10
    ??...???????#? 1,9
    ?..?###??.?.??#??. 5,4
    ?.??##.?.??#??#???? 3,9
    #???.??#???#???? 3,4,3,2
    ????????#?#??#??? 11,3
    ?????#?????#...?? 3,1
    #?????..??##?.??? 1,4,3,1
    ????##??##?###.#. 1,1,3,6,1
    ?#???.#.?? 4,1,2
    #.?.???#??#.? 1,1,2,1
    ????.?????#??????. 3,8
    ????.?.#?#? 4,4
    ???#??#????##??.. 6,5
    ###??#????#?.. 7,2
    ??.??#???###?. 1,7
    ????????.?.?#???? 3,3,1,4
    ?#?#..##???????# 3,2,7
    #?????.??????? 2,1,1,6
    #??..?#??## 3,2,3
    ??.?.????.#??? 1,3,4
    .?#???##.???.??? 6,2
    ??.??.?.?#####?? 1,6
    ?#???#?#.?.????..? 7,3
    ??#.??###?###?.? 3,7
    ?.?.?..??###? 1,1,1,6
    ??.??#??#?.??.?? 1,4,1,1,1
    ?#?#?.##????? 5,2,1,1
    #??????#?. 5,2
    ?#?#??.?..?.? 4,1
    ?????????..#.??? 2,2,1,1,1
    .?..????#??#?##?#? 1,1,1,10
    ??????.?????.??? 4,3
    ???????????#?. 4,2
    .????#??.?.??#???#? 1,3,1,2,2
    ??##?#????##?##???#? 6,10
    ?#???????????. 5,4
    ???##?#?????#.?.?# 10,2,2
    .????.???#?##.????? 2,7,2
    ??????##???.?.????. 1,4,2,1,1,1
    ???#?????#??#????#.? 1,3,4,3,1
    ?#???#.#??.? 2,1,1,1
    ?.???#?.??#?#??? 2,8
    #.????#?.?..??#? 1,1,2,1,3
    .????.?????.? 3,1,2
    ?????#?????.? 3,2,3
    ?#?.#??##?. 3,1,2
    ??###??????? 6,1,1
    ????????#??? 1,1,3
    ???.?.#??? 1,1,1
    .??.??#.?? 1,1,1
    ?##.???##???#?#.??? 2,7,1,2
    ?#??.??.#??#???? 2,1,2,1,1
    ##????#?##?.?#.?? 3,1,5,1,1
    ?##?.?#.#??##? 3,1,1,4
    #??.??????? 1,4
    .???##??????.????#?? 1,8,1,2
    ???#.#.?????????? 1,1,1,10
    ????.?#??#?#??#?? 1,10
    ?.?????.???.??#??? 1,1,1,2,2,1
    ??.???##.?????? 5,2
    ??.?.#???#??? 1,1,3,3
    ????##????..#??? 6,1,1,1
    ?????#.??#?##.?? 2,2,4,1
    ?#..???????? 1,1,3
    #??????#?...#? 9,2
    ?..?.??#?.#? 1,1,2,1
    ..????????? 1,1,1
    ??.??#??.???.? 1,5,1
    ..?.##..??#??#?????? 2,10
    ???#..?#???#????? 1,1,2,8
    .???????#.????#?? 4,2
    ???.?#???.???.?.. 2,3,2,1
    ??#?#?????#??? 1,4,1,2
    ????#.???..#?### 3,1,1,1,3
    ????#???..?#?# 4,1,2,1
    ?.??.????##?#?#.? 3,6
    .???.????????#????? 1,7,1,2
    ??#??.??#???.? 3,4,1
    .??.?#.?##?????.?.. 1,2,2,2,1
    #???.?.??? 4,1,2
    ?.??.?#??#?????????. 2,5,4,1
    ..??????????????#?.? 1,6,2,1
    ??...#.?##? 1,2
    .???####?#.???. 1,6,1
    ??#..??#??.?##?# 3,1,1,2,1
    #?..?##??..??#? 1,5,1
    ?#?#????????? 6,1,2
    ?.#?.?.#???? 2,1,5
    ?..????#??????.?. 1,2,1,5,1
    .???#??#???#?#??#? 2,3,4,1
    .???....#??.??. 1,3
    ???#?.??..#???. 1,1,1,4
    ...???.#?? 1,1
    .#???.???## 1,1,5
    ??#??##???.?????. 4,5,5
    ??#?##?...??? 1,3,2
    #????#.????#?#??? 1,1,1,7,1
    ????#??#..?.??????. 8,1,1,2,1
    ?#????#??#?????#.?? 8,4,1,1
    .?????.##??????#???. 1,1,12
    #??.??#??? 2,3,1
    .?#?###?#??###?#?#?. 1,15
    ?#.#?????# 1,4,2
    ??#???###???????#?.# 9,7,1
    .??.??#???. 1,4
    .??.?#???#???.###?. 1,7,3
    ????#??#???#?.??? 1,1,2,3,1
    ???#?#?????..?.????. 10,1,1,1
    ??##?#??#?????#????? 1,7,1,6
    ??.?#?#???.????? 2,7,2
    ??#?.?.????. 3,3
    .??#.#?##??? 1,1,6
    ??#??????###??.? 1,3,1,3,1
    ..?#?.#???.?#? 2,1,1,3
    ?.?##????#.?#?? 7,3
    ??###???.?. 4,1
    ??.?#?#??#??. 1,7
    ??????.##?.#??#?? 1,1,1,2,6
    ?.?###.?#???#???##?? 4,11
    .#?#??##?.???#???? 8,5
    .?.??##???.??.? 1,7,2
    ????????#???#??? 3,2,5,2
    ??.?###.????????.?# 1,4,3,1,1
    #.????##??#??????#? 1,1,13
    #????#???#.??#. 1,5,1
    ????????#???#??.??# 1,1,1,8,3
    ????.?????.??# 3,4,1
    ??.??#???.. 1,4
    ??.??##?.????##??? 2,3
    ????????????#?????? 1,10
    ?#??#??.?.#?.#....?? 7,1,1,1,1
    ?.?#????## 4,2
    .?.#????##. 1,5
    .???????????? 3,1,1,1
    #?????????.?###?# 2,3,1,1,5
    ?#?#.#??#.??? 1,1,4,1
    ???.#??????????? 2,8,2
    ##?#?#?.???? 6,2
    ??.?????##.#? 1,1,4,1
    ??????.#?##? 1,4
    ???#????????.#.????? 4,1,3,1,5
    ?#?..??##? 3,4
    ?????.??##?.? 2,1,2,1
    ?#????#????? 1,7
    .???#.??##???????. 2,1,7
    ???####?.?#??..? 6,3
    ?.?#???.????. 5,1
    .?#???.?###?#??## 3,1,10
    ?###??????#?????###? 5,5,3
    .??#?.????#? 4,2
    ##.?##?#.?.#??#.??? 2,2,1,1,4,2
    ????#?????#?##??##?? 3,1,2,6,3
    ...??##..??# 4,2
    ?.?.#???#? 1,1,1
    .#???.????? 1,2,1
    .#???#???#?#????#. 1,1,2,1,1,2
    ???.#??????? 1,3,1,1
    .??#???#??#????#?? 1,2,1,8
    ?#????????? 4,1,1
    ?????##??##?? 3,7
    ??.????#.??? 1,5,1
    .??###?##??#?# 7,3
    ???##?..?? 1,3,2
    ??#.?.????#? 2,1,2
    ?#??#???#??#?.#. 2,1,6,1
    ?.?????.?#?. 1,1,1,2
    .??#???#?.?#?#??# 3,3,2,1,2
    ?#??..#.???? 3,1,1
    ????????#????.?.#? 1,1,6,1,1
    ??#?#??????#?.?.?.#? 5,1,3,1,1,1
    ???#???????#??#??. 2,3,10
    ???#?#?.?????#?#? 4,1,5
    ?..??#???????????? 1,4,1,1,1,3
    #.?????###?#??? 1,12
    ?.??????##??#??????? 1,11,2,1
    #?.??##??#??. 1,9
    ????#?????????? 9,1
    ?#.?#??.???.?????#? 1,3,1,1,1,2
    ??.?..????.?? 1,1,3,1
    ?#..?#???????.? 1,2,2,1,1
    #.??#??#??#? 1,7
    #?#?#???????.?????. 6,5,1,1
    .????????.?#?#. 1,1,1,4
    ??.???????#. 1,1,1,1
    ??????.?#.???? 2,1,2,1
    ..?#?##???????? 2,7
    ?#?#?????.??? 8,1
    #?.?#????.?? 2,3,2,1
    ????.?.?#???? 1,1,2,1
    ?.???#?.??.?.?.?. 4,2,1,1,1
    .#???#?#??#??. 1,9
    ?????#??.?? 3,3,1
    ?#?????..?.??###?# 5,7
    ?????#??.##. 4,2
    .##.??#??????#?##. 2,2,6
    #?.???.?#?.?????. 1,3,2,1,1
    ?##?#?????? 2,4,1
    ?#?????#??????#?. 10,1,2
    .?#..?#???##?.???? 2,1,4,2,1
    ???????.????##.??? 3,3
    ??###?.????.??##???? 6,2,1,3,1
    .#?####??.?.?#???# 8,5
    ?????????# 1,7
    .??..###???#??#?.??? 10,1
    #????..????#?#? 1,2,2,5
    ????###?????? 8,3
    #..??.???????#??? 1,1,2,1,4
    .?#????#?#??.?? 11,1
    ?#?????#..??#?.??? 5,1,1,1,1
    ?.??#??????##?##.. 1,2,1,1,6
    ?###?????#.?# 8,1,1
    ??#??.?#???????## 3,3,5
    ??.#?????.?????#???? 1,1,1,1,2,4
    ??????????? 1,2
    ..???.???#? 2,3
    ??.??#?????#????.? 2,8,2,1
    ?????#??????#? 1,4,1,3
    ?.?????..??? 1,1,2,1
    ?#??#????##?????#??# 4,3,7
    ?????.?##??.????.#. 3,3,1,1,2,1
    ?#???????????#.??#.? 2,9,3
    ?????###.??.#.?????? 1,4,1,1,1,2
    .?###.??.? 3,1
    ???....??##.? 1,4
    ??###??.?.#?..?? 5,1,1,2,1
    ???##??????#???? 3,1,3,1
    ?????#???????#.? 2,1,1,1,3
    ???????#??#???# 2,10
    .??##????????? 1,2,6,1
    ??.#?#???????# 1,4,1,2
    ???#?.?##?#.????? 1,3,4,1,2
    ?#????..?##? 2,3
    ??????#??.?????? 1,6,2,1,1
    .?##??.?.?#????## 5,3,3
    ?#??????.????#??.??? 1,1,2,6,1,1
    ?.??#??..##?.??. 1,5,2,1
    ?#?..???#?.?? 3,5,1
    ??????..???? 3,1
    .?.???????#????. 1,9
    ??????#?#??????.???? 14,1
    .????????????#??. 1,7
    ????#.?##?## 3,5
    .?.##?????.? 1,3,1
    ???#??????##??#??. 1,1,11
    ????##????? 2,2,2
    ????????.??.#??#??. 3,2,1,6
    #???#?#??#???. 1,7,1
    ..???????????.##??? 9,5
    ??.????????#??# 2,1,1,2,1
    ?#??????..?. 3,1,1
    #???.??????.#??.? 1,1,2,2
    ?#??????.# 2,3,1
    ????#??.##?.??#. 1,2,3,1
    .????#???????#? 2,1,4
    .?#????.?.???##. 1,3,5
    .?.?#????#. 3,1
    ?#???.???#?##?? 3,1,5
    ????#?#?????????..?. 9,2
    .?????#????????##?#? 4,1,1,1,2,5
    .???#??????????? 1,5,6
    ??.??#?##???##?? 1,4,6
    ??..??.##?# 1,1,4
    #???.??????????????? 3,11,1
    ?.?##????.???????? 1,3,2,7
    ?#??.?.?#??.? 3,1,3,1
    ..??#??.???#?????? 3,5
    ???#.??????? 3,1,3
    ?#?##??????? 9,1
    ???#??#???????# 1,7,1,1
    ??##????.##???? 4,2
    .#..???..??#?.?#?# 1,1,1,1,2,1
    .?????..?? 1,1,2
    ?.????????. 1,5,1
    ?#????.??.#.?????#. 3,1,2,1,2,3
    ?#???????? 3,1,1
    ??#?#?##????#?? 9,3
    .#??#?#??. 1,3
    .#??#?.??#?#?..? 4,1,2,1
    .???.?.?#?#?.?? 1,1,5,1
    ?..???#????????..? 3,2
    #??#???.???#?????#? 6,1,4,3
    ?????#?.????????.? 1,1,8,1
    .#??#????.#?.#?? 1,3,1,1,1
    ??????????????#?#?? 1,10
    ???#?#?#?? 1,1,3
    ???.?????#.#? 3,1,2,1
    ???.???.?# 1,3,1
    ?#?????..?#???#??? 6,3,4
    ?#?#??.##?. 4,2
    ??????????#?.????. 1,6,2,4
    ?#??#?????????? 1,9,1
    ???##?#??#??? 1,9
    #??????##?? 2,6
    ??.??????#?#?.???.? 1,3
    .?#?#?.?????????.? 2,1,1,2,1,1
    ??..#????.###?#? 2,1,1,1,5
    ???.?????#??? 1,4
    .?????##?#?..?.? 3,5,1
    .#????#??.???.?# 1,1,2,2,1
    ??#???##?#?????.???? 8,1,2,1
    #?#.#????.?#???? 1,1,5,5
    .##????#??#..?.?.?.? 7,2
    #????#?????.? 1,1,2,3
    ??.#????#? 1,2,1
    ?#?????..??#.??? 4,3
    .?????#.#??.? 6,1,1
    ??#?.??????.??#.??# 3,6,1,1,1
    #?#?..??##????????# 4,13
    ????###?.??#...??#?? 7,3,3
    ?????????#.???# 8,2,1
    ??###??##?..?.??##.? 10,1,2
    .#?????????#???#?#. 4,1,8
    ????#?.????#???..? 5,1,4,1,1
    ??.????.#?????##? 1,3,1,1,2
    ??.#??#.?.?? 1,1,1,1
    ??.??????#?? 1,6
    .???.???.##??.?. 2,2,4,1
    ???#?###?.?? 1,1,3
    ???#.?????..#.. 1,1,2,1,1
    ?#?#?.??????#????# 1,2,1,1,8
    #?????.????? 1,1,1,1
    .????#..?? 4,1
    ??###????????#?##.? 1,3,1,1,4,1
    ????..?.#?.. 2,2
    ??????#??#??.?? 1,1,1,4,1
    ?????#????.?????# 1,7,4
    ?.#???#?#?? 1,7
    ??.??.??.??..##??#?? 2,2,1,6
    ????.??##?. 1,1,5
    #?#.#??????.#.?#?.?. 3,4,1,1,1,1
    #?????#????? 2,5,1
    ??#?#?????.#?#?? 6,4
    ..???#??????. 1,1,5
    .?.?#.#???#???? 1,1,1,4"
  end

end
