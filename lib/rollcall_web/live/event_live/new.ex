defmodule RollcallWeb.EventLive.New do
  use RollcallWeb, :live_view

  alias Rollcall.Events
  alias Rollcall.Events.Event

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:event, %Event{})}
  end

  defp page_title(:new), do: "New Event"
end
