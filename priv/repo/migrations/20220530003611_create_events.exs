defmodule Rollcall.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :start_date, :date
      add :end_date, :date
      add :num_people, :integer
      add :times, :jsonb
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
