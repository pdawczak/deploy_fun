defmodule DeployWeb.FunChannel do
  use DeployWeb, :channel
  require Logger

  @vsn "0.0.2"

  @impl true
  def join("fun:lobby", _payload, socket) do
    send self(), :after_join

    {:ok, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    socket = assign(socket, :rand, :rand.uniform(1000))

    IO.inspect(socket.assigns, label: ":after_join")

    Process.send_after(self(), :gen_new_rand, 1000)

    {:noreply, socket}
  end

  @impl true
  def handle_info(:gen_new_rand, socket) do
    socket = assign(socket, :rand, :rand.uniform(1000))

    IO.inspect(socket.assigns, label: ":gen_new_rand")

    Process.send_after(self(), :gen_new_rand, 1000)

    push socket, "update", socket.assigns

    {:noreply, socket}
  end

  @impl true
  def code_change(vsn, socket, extra) do
    Logger.info("CHANNEL [code_change] -> vsn: #{inspect vsn}, socket: #{inspect socket}, extra: #{inspect extra}")

    {:ok, assign(socket, :bar, "baz")}
  end
end
