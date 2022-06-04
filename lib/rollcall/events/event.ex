defmodule Rollcall.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :end_date, :date
    field :name, :string
    field :num_people, :integer, default: 1
    field :start_date, :date
    field :times, :map, default: %{
      0 => false,
    }
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:start_date, :end_date, :num_people, :times, :name])
    |> validate_required([:start_date, :end_date, :num_people, :times, :name])
  end
end
