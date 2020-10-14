defmodule Mobilizador.Repo.Migrations.CreateLeads do
  use Ecto.Migration

  def change do
    create table(:leads) do
      add :name, :string
      add :phone, :string
      add :date_attendance, :date
      add :vote, :boolean
      add :valid, :boolean
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:leads, [:user_id])
  end
end
