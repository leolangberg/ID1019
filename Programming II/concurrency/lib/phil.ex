defmodule Phil do

  #would need a HEALTH BAR else stuck in infinite loop
  @dreaming 300
  @eating 200
  @delay 100
  @timeout 1000

  def start(name, left, right, hunger, health, ctrl) do
    spawn_link(fn() -> thinking(name, left, right, hunger, health, ctrl) end)
  end


  def thinking(name, _, _, 0, health, ctrl) do
    IO.puts(" #{name} is FINISH. health: #{health}")
    #:io.format(" ~w is FINISH \n", [name])
    #send(gui, {:action, name, :done})  wxWidgets
    send(ctrl, :done)
    :ok
  end
  def thinking(name, _, _, hunger, 0, ctrl) do
    #IO.puts(" #{name} is DEAD. health: #{hunger}")
    send(ctrl, :done)
  end
  def thinking(name, left, right, hunger, health, ctrl) do
    #IO.puts(" #{name} is dreaming. hunger: #{hunger}  health: #{health}")
    sleep(@dreaming)
    waiting(name, left, right, hunger, health, ctrl)
  end


  def waiting(name, left, right, hunger, health, ctrl) do
   # IO.puts(" #{name} is waiting. hunger: #{hunger}  health: #{health}")
    #Chopstick.request(left, @timeout)
    #sleep(@delay)
    #Chopstick.request(right, @timeout)  #will never get a sorry when strength is implemented
    #eating(name, left, right, hunger, health, ctrl)
    case Chopstick.request(left, @timeout) do
      :ok ->
        sleep(@delay) #<-- gives deadlock
        case Chopstick.request(right, @timeout) do
          :ok ->
            eating(name, left, right, hunger, health, ctrl) #strength
          :sorry ->
            Chopstick.return(left)
            Chopstick.return(right)  #return this even if we dont get it, so that there is no hidden shadowrequest behind
            thinking(name, left, right, hunger, health - 1, ctrl)   #return chopstick incase cant get both?  #strength -1
        end
      :sorry ->
        Chopstick.return(left)
        thinking(name, left, right, hunger, health - 1, ctrl)  #strength -1
    end
  end

  def waiting(name, left, right, hunger, health, ctrl) do
    Chopstick.request(left)
    Chopstick.request(right)
    eating(name, left, right, hunger, health, ctrl)
  end

  def eating(name, left, right, hunger, health, ctrl) do #strength
    #:io.format(" ~w is eating \n", [name])
    sleep(@eating)
    Chopstick.return(left)
    Chopstick.return(right)
    thinking(name, left, right, hunger - 1, health, ctrl)
  end




  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(t) end

  def sleeprandom(0) do :ok end
  def sleeprandom(t) do :timer.sleep(:rand.uniform(t)) end

end
