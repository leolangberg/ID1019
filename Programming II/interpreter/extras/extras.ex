defmodule Extras do

  #"{:a, :b}" => {:cons, {:atm, :a}, {:atm, :b}}

  #sequence representation
  #[ {:match, {:var, :x}, {:atm, :b}} , {:var, :x} ]

  def eval({:atm, a}, _) do {:ok, a} end #if you take in a atom then return the data structure correspondant
  def eval({:var, v}, env) do
    case Env.lookup(env, v) do #if you take in a variable then it needs to check that the variable is linked to something
      :nil ->
        :error
      {:ok, str} ->
        {:ok, str}
    end
  end
  def eval({:cons, e1, e2}, env) do
    case eval(e1, env) do #if s1 exist check s2
      {:ok, s1} ->
        case eval(e2, env) do #if s2 also exist return data structure {s1, s2}
          {:ok, s2} ->
            {:ok, {s1, s2}}
          :error ->
            :error
        end
      :error ->
        :error
    end
  end


  def eval_expr({:fun, param, free, seq}, env) do
    {:closure, param, seq, EnvList.closure(env, free)} #ny env med bara fria variablerna
  end

  def eval_expr({:fun, param, free, seq}, env) do
    case Envlist.closure(free, env) do
      :error ->
        :error
      {:ok, closure} ->
        {:closure, param, seq, closure}
    end
  end


  def eval_expr({:apply, e, args}, env) do
    case eval_expr(e, env) do
      {:closure, par, seq, closure} ->
        case args = eval_args(args, env) do
          {:ok, args} ->
            case Env.add_all(par, args, closure) do
              {:ok, env} ->
                eval_seq(seq, env)
              :error ->
                :error
            end
          :error ->
            :error
        end
      _ ->
        :error
    end
  end




  def eval_cls([], _, _) do :error end
  def eval_cls([{:cls, p, seq} | clauses], s, env) do
    removed = scope(p, env)
    case eval_match(p, s, removed) do
      :fail ->
        eval_cls(clauses, s, env)
      {:ok, env} ->
        eval_seq(seq, env)
    end
  end


  #macro
  fun append(xs, ys) do
    case xs do
      :nil -> ys
      {h,t} -> {h, append(t, ys)}
    end
  end

  fun nreverse(lst) do
    case lst do
      :nil > :nil
      {h,t} -> append(nreverse(t), {h, :nil})
    end
  end
    #{:fun, [:x], [:y], [{:match, {:var, :y}, {:atm, :a}}, {:cons, {:var, :y}}] }








end
