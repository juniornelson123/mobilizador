defmodule MobilizadorWeb.Admin.SupervisorController do
  use MobilizadorWeb, :controller
  import Ecto.Query

  alias Mobilizador.Repo
  alias Mobilizador.Users.User

  def index(conn, _params) do
    query = from(User, where: [kind: "supervisor"])

    users = Repo.all(query)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Pow.Ecto.Context.create(user_params |> Map.put("kind", "supervisor"), [user: Mobilizador.Users.User, repo: Mobilizador.Repo ]) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "supervisor created successfully.")
        |> redirect(to: Routes.supervisor_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    render(conn, "show.html", supervisor: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)

    case User.update_changeset(user, user_params) |> Repo.update do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Supervisor updated successfully.")
        |> redirect(to: Routes.supervisor_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    {:ok, _user} = Repo.delete(user)

    conn
    |> put_flash(:info, "Supervisor deleted successfully.")
    |> redirect(to: Routes.supervisor_path(conn, :index))
  end
end
