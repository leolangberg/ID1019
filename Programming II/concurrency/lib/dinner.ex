defmodule Dinner do

  #make the process sequential not cirular
  #have to pick locks in order
  #always try to pick c1 before c2

  def start(hunger, health) do spawn(fn -> init(hunger, health) end) end

  def init(hunger, health) do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    t0 = :erlang.timestamp()
    #Philosopher.start(5, c1, c2, :aristotle, ctrl)
    #Philosopher.start(5, c2, c3, :plato, ctrl)
    #Philosopher.start(5, c3, c4, :socrates, ctrl)
    #Philosopher.start(5, c4, c5, :cicero, ctrl)
    #Philosopher.start(5, c5, c1, :seneca, ctrl)
    Phil.start(:socrates, c1, c2, hunger, health, ctrl)
    Phil.start(:plato, c2, c3, hunger, health, ctrl)
    Phil.start(:aristotles, c3, c4, hunger, health, ctrl)
    Phil.start(:cicero, c4, c5, hunger, health, ctrl)
   # Phil.start(:seneca, c5, c1, 5, ctrl)
   Phil.start(:seneca, c1, c5, hunger, health, ctrl) #now its not circular
    wait(5, [c1, c2, c3, c4, c5])
  end

  #def wait(0, t0) do
  #  t1 = :erlang.timestamp()
  #  Process.exit(self(), :kill)
  #end
  #def wait(n, t0) do
#
 # end
  def wait(0, chopsticks) do
    IO.puts("END?")
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
  end
  def wait(n, chopsticks) do
    receive do
      :done ->
        wait(n-1, chopsticks)
        IO.puts("DONE RECEIVED")
      :abort ->
        Process.exit(self(), :kill)
    end
  end


  def dinner(_) do
    receive do
      :quit ->
        45 / 0
    end
  end


end
