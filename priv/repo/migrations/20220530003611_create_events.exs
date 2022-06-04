defmodule Rollcall.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :num_people, :integer, null: false
      add :times, :jsonb, null: false
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
