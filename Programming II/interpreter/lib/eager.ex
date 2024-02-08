defmodule Eager do

  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case EnvList.lookup(env, id) do
      nil ->
        :error #key (id) does not exist
      {_, str} ->
        {:ok, str} #key exist return value
    end
  end
  def eval_expr({:cons, tr, ts}, env) do
    case eval_expr(tr, env) do
      :error ->
        :error
      {:ok, tr} ->
        case eval_expr(ts, env) do
          :error ->
            :error
          {:ok, ts} ->
            {:ok, {tr, ts}}
        end
    end
  end

  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do #{:var, :x}
      :error ->
        :error
      {:ok, str} -> #{:atm, :a}
        eval_cls(cls, str, env) #( [{:clause, {:atm, :b}, [{:atm, :ops}]}, {:clause, {:atm, :a}, [{:atm, :yes}]}]}, {:atm, :a}, env)
    end  #list of clauses, data structure, environment
  end

  def eval_expr({:lambda, par, free, seq}, env) do
    IO.write("eval_expr(:lambda)\n")
    IO.inspect(par)
    IO.inspect(free)
    IO.inspect(env)
    case EnvList.closure(free, env) do
      :error ->
        :error
      closure -> #new envirnoment
        {:ok, {:closure, par, seq, closure}}
    end
  end

  def eval_expr({:apply, expr, args}, env) do #expr = {:lambda, par, free, seq}
    IO.write("eval_expr(:apply)\n")
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, {:closure, par, seq, closure}} ->
        case eval_args(args, env) do  #(args) = list of expr, env ??
          :error ->
            :error
          {:ok, strs} ->
            IO.write("{:ok, strs}\n")
            env = EnvList.args(par, strs, closure)
            eval_seq(seq, env)
        end
    end
  end

  def eval_expr({:fun, id}, env) do
    {par, seq} = apply(Prgm, id, [])
    {:ok, {:closure, par, seq, EnvList.new()}}
  end



  def eval_args([], _) do {:ok, []} end #{:ok, Enum.reverse(strs)}
  def eval_args([arg | rest], env) do
     case eval_expr(arg, env) do
      :error->
        :error
      {:ok, str}->
        {:ok, str2} = eval_args(rest, env)
        {:ok, [str | str2]} #[str | eval_args(rest, env)] #needs to be {:ok, strs} return
      end
  end


  #Clause looks at (e -> :a) and determines which statement (:a or :b) matches
  def eval_cls([], _, _) do :error end
  def eval_cls([{:clause, p, seq} | cls], e, env) do #{:clause, {:atm, :b}, [{:atm, :ops}]}
    #IO.inspect(p)
    #IO.inspect(e)
    new_env = eval_scope(p, env) #remove variable {:atm, :b} from env
    case eval_match(p, e, new_env) do #try to match {:atm, :b} with {:atm, :a} (:var, :x)
      :fail ->
        eval_cls(cls, e, env) #new try on next clause {:clause, {:atm, :a}, {}}
      {:ok, new_env} ->
        eval_seq(seq, new_env) #[{:atm, :yes}] is returned, which gives -> [e] -> eval_expr({:atm, id}, _) -> {:ok, :yes}
    end
  end


  def eval_match(:ignore, _, env) do {:ok, env} end
  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, id}, str, env) do
    case EnvList.lookup(env, id) do
      nil ->
        {:ok, EnvList.add(env, id, str)} #does not exist in map then add
      {_, ^str} ->
        {:ok, env} #exist in map and already same (wanted) value
      {_, _} ->
        :fail  #already exist differnet value in map
    end
  end
  def eval_match({:cons, hp, tp}, {a, b}, env) do
    case eval_match(hp, a, env) do
      :fail ->
        :fail #already exists other value for hp in map
      {:ok, env} ->  #hp has been given value then do same check for tp
        eval_match(tp, b, env) #return either :fail or {:ok, env}
    end
  end
  def eval_match(_, _, _) do :fail end



  def extract_vars(p) do extract_vars(p, []) end
  def extract_vars({:var, v}, sofar) do [v | sofar] end #return variable in the pattern
  def extract_vars({:atm, a}, sofar) do sofar end
  def extract_vars(:ignore, sofar) do sofar end
  def extract_vars({:cons, v, w}, sofar) do
    sofar = extract_vars(v, sofar) #sofar updated
    extract_vars(w, sofar)
  end


  #Scope = Take existing environment, empty variables that we need for future use
  def eval_scope(p, env) do EnvList.remove_all(env, extract_vars(p)) end


  def eval_seq([e], env) do eval_expr(e, env) end #end of sequence where only expression is left
  def eval_seq([{:match, p, e} | seq], env) do #try to match p & e
    case eval_expr(e, env) do #is a an expression
      :error -> #key a does not exist
        :error
      {:ok, str} -> #key exist
        env = eval_scope(p, env) #remove old value, return updated environment
        case eval_match(p, str, env) do #match the new value     #NOTE str --> :a    e --> {:atm, :a}
          :fail ->
            :error   #eval_cls(clauses, s, env) use old env
          {:ok, env} ->
            eval_seq(seq, env) #recursion, seq is either match or exp
        end
    end
  end




  def eval([]) do :error end
  def eval(seq) do
    env = EnvList.new()
    eval_seq(seq, env)
  end




  def test do
    env = EnvList.new()
    env = EnvList.add(env, :x, :b)

    #env = eval_match({:cons, {:var, :x}, {:var, :y}}, {:a, :b}, env)

    #sequence = EnvList.append([], {:match, {:cons, {:var, :x}, {:var, :y}}, {:cons, {:atm, :a}, {:atm, :b}}})
    #sequence = EnvList.append(sequence, {:match, {:var, :x}, {:atm, :c}})
    #sequence = EnvList.append(sequence, {:cons, {:var, :x}, {:var, :y}})


    #seq = EnvList.append(seq, {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}})
    #seq = EnvList.append(seq, {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}})


    #eval_seq(seq, env)


  end
end
