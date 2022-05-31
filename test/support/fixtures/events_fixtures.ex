defmodule Rollcall.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rollcall.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2022-05-29],
        end_hour: 42,
        name: "some name",
        num_people: 42,
        start_date: ~D[2022-05-29],
        start_hour: 42
      })
      |> Rollcall.Events.create_event()

    event
  end
end
