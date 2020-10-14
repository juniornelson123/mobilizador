defmodule Mobilizador.Repo.Migrations.AddColumnsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :kind, :string
      add :phone, :string
      add :parent_id, :integer
    end
  end
end
