defmodule Mobilizador.Setting.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :description, :string
    field :file, :string
    field :name, :string
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(material, attrs) do
    material
    |> cast(attrs, [:name, :file, :description])
    |> validate_required([:name, :file, :description])
  end
end
