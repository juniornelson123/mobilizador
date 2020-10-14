defmodule Mobilizador.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Pow.Ecto.Schema

  schema "users" do
    field :name, :string
    field :kind, :string, default: "mobilizador"
    field :phone, :string

    belongs_to :parent, Mobilizador.Users.User

    has_many :children, Mobilizador.Users.User, foreign_key: :parent_id
    has_many :leads, Mobilizador.Attendance.Lead
    has_many :link_attendances, Mobilizador.Url.LinkAttendance
    
    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name, :kind, :phone, :parent_id])
    |> Ecto.Changeset.validate_required([:name, :kind, :phone])
  end
  
  def update_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:name, :kind, :phone, :parent_id])
    |> Ecto.Changeset.validate_required([:name, :kind, :phone])
  end
end
