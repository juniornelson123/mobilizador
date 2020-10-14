defmodule Mobilizador.Url.LinkAttendance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "link_attendances" do
    field :name_prospect, :string
    field :token, :string
    field :url, :string

    belongs_to :user, Mobilizador.Users.User
    belongs_to :lead, Mobilizador.Attendance.Lead

    timestamps()
  end

  @doc false
  def changeset(link_attendance, attrs) do
    link_attendance
    |> cast(attrs, [:name_prospect, :token, :url, :user_id, :lead_id])
    |> validate_required([:name_prospect, :url, :user_id, :lead_id])
  end
end
