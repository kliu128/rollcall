defmodule RollcallWeb.EventLive.FormComponent do
  use RollcallWeb, :live_component

  alias Rollcall.Events

  @impl true
  def update(%{event: event} = assigns, socket) do
    changeset = Events.change_event(event)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:times, %{})
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"event" => event_params}, socket) do
    changeset =
      socket.assigns.event
      |> Events.change_event(event_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"event" => event_params}, socket) do
    save_event(socket, socket.assigns.action, event_params)
  end

  def handle_event("toggle_time", %{"time" => time, "toggle" => toggle}, socket) do
    IO.puts "TOGGLE TIME #{toggle} #{time}"
    {integer, ""} = Integer.parse(time)
    times = Map.put(socket.assigns.times, integer, toggle == "0" )
    # IO.puts event
    {:noreply, assign(socket, :times, times)}
  end

  defp save_event(socket, :new, event_params) do
    event_params = Map.put(event_params, "times", socket.assigns.times)
    case Events.create_event(event_params) do
      {:ok, _event} ->
        {:noreply,
         socket
         |> put_flash(:info, "Event created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
