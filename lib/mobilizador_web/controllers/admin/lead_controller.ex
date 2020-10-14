defmodule MobilizadorWeb.Admin.LeadController do
  use MobilizadorWeb, :controller
  import Ecto.Query

  alias Mobilizador.Repo
  alias Mobilizador.Users.User
  alias Mobilizador.Attendance
  alias Mobilizador.Attendance.Lead

  def index(conn, _params) do
    leads = Attendance.list_leads() |> Repo.preload([user: [:parent]])
    render(conn, "index.html", leads: leads)
  end

  def new(conn, _params) do
    changeset = Attendance.change_lead(%Lead{})
    query = from(User, where: [kind: "mobilizador"])

    users = Repo.all(query)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"lead" => lead_params}) do
    
    case Attendance.create_lead(lead_params) do
      {:ok, lead} ->
        conn
        |> put_flash(:info, "Lead created successfully.")
        |> redirect(to: Routes.lead_path(conn, :show, lead))

      {:error, %Ecto.Changeset{} = changeset} ->
        query = from(User, where: [kind: "mobilizador"])

        users = Repo.all(query)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    lead = Attendance.get_lead!(id)
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

    case Attendance.update_lead(lead, lead_params) do
      {:ok, lead} ->
        conn
        |> put_flash(:info, "Lead updated successfully.")
        |> redirect(to: Routes.lead_path(conn, :show, lead))

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
    |> redirect(to: Routes.lead_path(conn, :index))
  end
end
