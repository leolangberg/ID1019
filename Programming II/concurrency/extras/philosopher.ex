defmodule Philosopher do

  #right = request chopstick
  #left = request chopstick

  def start(hunger, right, left, name, ctrl) do
    philosopher = spawn_link(fn() -> sleeping({hunger, right, left, name, ctrl}) end)
  end

  #PHILOSOPHER EATING PHASE
  def eating({hunger, right, left, name, ctrl}) do
    IO.puts("PHILOSOPHER STATE: EATING")

    hunger = hunger - 1
    case hunger do
      0 ->
        send(ctrl, :done)
      _ ->
        Chopstick.return(left)
        Chopstick.return(right)
        Philosopher.sleeping({hunger, right, left, name, ctrl})
    end
  end


  #PHILOSOPHER WAITING PHASE
  def waiting({hunger, right, left, name, ctrl}) do
    IO.puts("PHILOSOPHER STATE: WAITING FOR CHOPSTICKS")
    case Chopstick.request(right) do
      :ok ->
        IO.puts("#{name} recieved (1) chopstick")
        case Chopstick.request(left) do
          :ok ->
            IO.puts("#{name} recieved both (2) chopsticks")
            Philosopher.eating({hunger, right, left, name, ctrl})
        end
    end
  end

  #PHILOSOPHER SLEEPING PHASE
  def sleeping({hunger, right, left, name, ctrl}) do
    #sleep(5000) #5s
    Philosopher.waiting({hunger, right, left, name, ctrl})
  end


  def waiting(name, left, right, hunger, strength, ctrl) do
    ref = make_ref()
    Chopstick.request(left, ref)
    Chopstick.request(right, ref)
    case Chopstick.wait(ref, @timeout) do
      :ok ->
        sleep(@delay)
        case Chopstick.wait(ref, @timeout) do
          :ok ->
            eating()
          :sorry ->
            Chopstick.return(left)
            CHopstick.return(right)
  end

  def request(chop, reft, time) do

  end
end
