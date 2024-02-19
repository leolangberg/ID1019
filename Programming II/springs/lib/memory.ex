defmodule Memory do

  def new() do %{} end #map?

  def store(k,v, mem) do Map.put(mem, k, v) end

  def lookup(k,mem) do
    case Map.fetch(mem, k) do
      :error -> nil
      {:ok, v} -> v
    end
  end

end
