defmodule MobilizadorWeb.Supervisor.LeadController do
  use MobilizadorWeb, :controller
  import Ecto.Query

  alias Mobilizador.Repo
  alias Mobilizador.Users.User
  alias Mobilizador.Attendance
  alias Mobilizador.Attendance.Lead
  alias Mobilizador.Url
  alias Mobilizador.Url.LinkAttendance

  def index(conn, _params) do
    leads = Attendance.list_leads() |> Repo.preload([:link_attendance, user: [:parent]])
    render(conn, "index.html", leads: leads)
  end

  def new(conn, _params) do
    changeset = Attendance.change_lead(%Lead{})
    query = from(User, where: [kind: "mobilizador"])

    users = Repo.all(query)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"lead" => lead_params}) do
    mobilizador = Pow.Plug.current_user(conn) |> Repo.preload([:parent])
    case Attendance.create_lead(lead_params |> Map.put("user_id", Pow.Plug.current_user(conn).id)) do
      {:ok, lead} ->
        link_attendance = %{
          name_prospect: lead.name,
          url: "http://wa.me/55#{mobilizador.parent.phone}?&text=Ol%C3%A1%20me%20chamo%20#{lead.name}%2C%20estava%20falando%20com%20o%20#{Pow.Plug.current_user(conn).name}%20e%20gostaria%20de%20saber%20mais%20sobre%20as%20propostas%20do%20Josel%C3%A9",
          user_id: Pow.Plug.current_user(conn).id,
          lead_id: lead.id,
        }
        Url.create_link_attendance(link_attendance)
        conn
        |> put_flash(:info, "Lead created successfully.")
        |> redirect(to: Routes.supervisor_lead_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        query = from(User, where: [kind: "mobilizador"])

        users = Repo.all(query)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    lead = Attendance.get_lead!(id) |> Repo.preload([:link_attendance, user: [:parent]])
    render(conn, "show.html", lead: lead)
  end

  def edit(conn, %{"id" => id}) do
    lead = Attendance.get_lead!(id)
    query = from(User, where: [kind: "mobilizador"])

    users = Repo.all(query)
    changeset = Attendance.change_lead(lead)
    render(conn, "edit.html", lead: lead, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "lead" => lead_params}) do
    lead = Attendance.get_lead!(id)

    case Attendance.update_lead(lead, lead_params |> Map.put("user_id", Pow.Plug.current_user(conn).id)) do
      {:ok, lead} ->
        conn
        |> put_flash(:info, "Lead updated successfully.")
        |> redirect(to: Routes.supervisor_lead_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        query = from(User, where: [kind: "mobilizador"])

        users = Repo.all(query)
        render(conn, "edit.html", lead: lead, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    lead = Attendance.get_lead!(id)
    {:ok, _lead} = Attendance.delete_lead(lead)

    conn
    |> put_flash(:info, "Lead deleted successfully.")
    |> redirect(to: Routes.supervisor_lead_path(conn, :index))
  end
end
