defmodule Mobilizador.Attendance.Lead do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leads" do
    field :date_attendance, :date
    field :name, :string
    field :phone, :string
    field :vote, :boolean, default: false
    field :valid, :boolean, default: false
    belongs_to :user, Mobilizador.Users.User
    has_one :link_attendance, Mobilizador.Url.LinkAttendance

    timestamps()
  end

  @doc false
  def changeset(lead, attrs) do
    lead
    |> cast(attrs, [:name, :phone, :date_attendance, :user_id, :vote, :valid])
    |> validate_required([:name, :phone, :date_attendance, :user_id])
  end
end
