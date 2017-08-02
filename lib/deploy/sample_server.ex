defmodule Deploy.SampleServer do
  use GenServer
  require Logger

  @vsn "0.0.3"

  def child_spec(_args) do
    IO.inspect "CHILDSPEC"
    %{id: __MODULE__, start: {__MODULE__, :start_link, []}}
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def check do
    GenServer.call(__MODULE__, :check)
  end

  def inc do
    GenServer.call(__MODULE__, {:inc, 2})
  end

  ###
  # Callbacks

  @impl true
  def init(:ok) do
    IO.inspect "initialising"
    Logger.info "Initialising"
    send self(), :print
    {:ok, 2}
  end

  @impl true
  def handle_call(:check, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:inc, num}, _from, state) do
    new_state = state + num
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_info(:print, state) do
    new_state = state + 1
    IO.inspect(new_state, label: "PRINT STATE")
    Logger.info("PRINTING STATE: #{inspect new_state}")
    Process.send_after(self(), :print, 3000)
    {:noreply, new_state}
  end

  def code_change("0.0.2", state, _extra) do
    Logger.info("UPGRADING WITH PROPER HOOK")
    {:ok, state / 2}
  end

  @impl true
  def code_change(vsn, state, extra) do
    Logger.info("UPGRADING [code_change] -> vsn: #{inspect vsn}, state: #{inspect state}, extra: #{inspect extra}")
    {:ok, state * 100}
  end
end
