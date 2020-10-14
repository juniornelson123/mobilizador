defmodule MobilizadorWeb.Supervisor.MobilizadorController do
  use MobilizadorWeb, :controller
  import Ecto.Query

  alias Mobilizador.Repo
  alias Mobilizador.Users.User

  def index(conn, _params) do
    query = from(u in User, where: u.kind == ^"mobilizador" and u.parent_id == ^Pow.Plug.current_user(conn).id)

    users = Repo.all(query) |> Repo.preload([:parent])
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    query = from(User, where: [kind: "supervisor"])

    users = Repo.all(query)

    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Pow.Ecto.Context.create(user_params |> Map.put("kind", "mobilizador"), [user: Mobilizador.Users.User, repo: Mobilizador.Repo ]) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "mobilizador created successfully.")
        |> redirect(to: Routes.supervisor_mobilizador_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        query = from(User, where: [kind: "supervisor"])

        users = Repo.all(query)
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    render(conn, "show.html", mobilizador: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, %{})
    query = from(User, where: [kind: "supervisor"])

    users = Repo.all(query)
    render(conn, "edit.html", user: user, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)

    case User.update_changeset(user, user_params) |> Repo.update do
      {:ok, user} ->
        conn
        |> put_flash(:info, "mobilizador updated successfully.")
        |> redirect(to: Routes.supervisor_mobilizador_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        query = from(User, where: [kind: "supervisor"])

        users = Repo.all(query)
        render(conn, "edit.html", user: user, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    {:ok, _user} = Repo.delete(user)

    conn
    |> put_flash(:info, "mobilizador deleted successfully.")
    |> redirect(to: Routes.supervisor_mobilizador_path(conn, :index))
  end
end
