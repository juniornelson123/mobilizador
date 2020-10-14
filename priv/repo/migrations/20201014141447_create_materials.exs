defmodule Mobilizador.Repo.Migrations.CreateMaterials do
  use Ecto.Migration

  def change do
    create table(:materials) do
      add :name, :string
      add :file, :string
      add :description, :text
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:materials, [:topic_id])
  end
end
