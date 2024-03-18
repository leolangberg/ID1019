defmodule Chop do

  def start do
    stick = spawn_link(fn -> available() end)
    #request(stick)
    #return(stick)
    #terminateStick(stick)
  end

  #state AVAILABLE means that the utencil is currently open for use
  #and to grab the utencil the keyword {:request} needs to be sent to
  #the process.
  def available() do
    IO.puts("     Chopstick: available")
    receive do
      {:request, ref, sender} ->
        send(sender, {:granted, ref})
        IO.puts("     Chopstick: {:request, #{inspect(sender)}}")
        Chop.gone(ref)
      :quit ->
        IO.puts("     Chopstick.available :quit -> :ok")
        :ok
    end
  end

  #state GONE means that the utencil is currently being used
  #and since it is not available is is therefore gone at the moment (not deleted)
  def gone(ref) do
    IO.puts("     Chopstick: gone")
    receive do
      {:return, ^ref} ->
        Chop.available()
      :quit ->
        IO.puts("     Chopstick.gone :quit -> :ok")
        :ok
    end
  end


  #INTERFACE
  def request(stick, ref, timeout) do
    send(stick, {:request, ref, self()})
    wait(ref, timeout)
  end


  def wait(ref, timeout) do
    receive do
      {:granted, ^ref} ->
        IO.puts("      Chopstick: Request Granted")
        :ok
      after timeout ->
        IO.puts("     Chopstick: Request Time Expired :sorry")
        :sorry
    end
  end

  def return(stick) do send(stick, :return) end

  def quit(stick) do
    send(stick, :quit)
    receive do
      :ok -> :ok    #Almost work, but is it necessary?
    end
  end


  #make_ref()     makes reference




end
