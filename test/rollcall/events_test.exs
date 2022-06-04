defmodule Rollcall.EventsTest do
  use Rollcall.DataCase

  alias Rollcall.Events

  describe "events" do
    alias Rollcall.Events.Event

    import Rollcall.EventsFixtures

    @invalid_attrs %{end_date: nil, end_hour: nil, name: nil, num_people: nil, start_date: nil, start_hour: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{end_date: ~D[2022-05-29], end_hour: 42, name: "some name", num_people: 42, start_date: ~D[2022-05-29], start_hour: 42}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.end_date == ~D[2022-05-29]
      assert event.end_hour == 42
      assert event.name == "some name"
      assert event.num_people == 42
      assert event.start_date == ~D[2022-05-29]
      assert event.start_hour == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{end_date: ~D[2022-05-30], end_hour: 43, name: "some updated name", num_people: 43, start_date: ~D[2022-05-30], start_hour: 43}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.end_date == ~D[2022-05-30]
      assert event.end_hour == 43
      assert event.name == "some updated name"
      assert event.num_people == 43
      assert event.start_date == ~D[2022-05-30]
      assert event.start_hour == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "events" do
    alias Rollcall.Events.Event

    import Rollcall.EventsFixtures

    @invalid_attrs %{end_date: nil, name: nil, num_people: nil, start_date: nil, times: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{end_date: ~D[2022-06-01], name: "some name", num_people: 42, start_date: ~D[2022-06-01], times: %{}}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.end_date == ~D[2022-06-01]
      assert event.name == "some name"
      assert event.num_people == 42
      assert event.start_date == ~D[2022-06-01]
      assert event.times == %{}
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{end_date: ~D[2022-06-02], name: "some updated name", num_people: 43, start_date: ~D[2022-06-02], times: %{}}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.end_date == ~D[2022-06-02]
      assert event.name == "some updated name"
      assert event.num_people == 43
      assert event.start_date == ~D[2022-06-02]
      assert event.times == %{}
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
