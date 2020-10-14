defmodule Mobilizador.Repo.Migrations.CreateLinkAttendances do
  use Ecto.Migration

  def change do
    create table(:link_attendances) do
      add :name_prospect, :string
      add :token, :string
      add :url, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :lead_id, references(:leads, on_delete: :nothing)

      timestamps()
    end

    create index(:link_attendances, [:user_id])
  end
end
