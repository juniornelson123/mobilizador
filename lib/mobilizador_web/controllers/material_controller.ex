defmodule MobilizadorWeb.MaterialController do
  use MobilizadorWeb, :controller

  alias Mobilizador.Setting
  alias Mobilizador.Setting.Material

  def index(conn, _params) do
    materials = Setting.list_materials()
    render(conn, "index.html", materials: materials)
  end

  def new(conn, _params) do
    changeset = Setting.change_material(%Material{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"material" => material_params}) do
    case Setting.create_material(material_params) do
      {:ok, material} ->
        conn
        |> put_flash(:info, "Material created successfully.")
        |> redirect(to: Routes.material_path(conn, :show, material))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    material = Setting.get_material!(id)
    render(conn, "show.html", material: material)
  end

  def edit(conn, %{"id" => id}) do
    material = Setting.get_material!(id)
    changeset = Setting.change_material(material)
    render(conn, "edit.html", material: material, changeset: changeset)
  end

  def update(conn, %{"id" => id, "material" => material_params}) do
    material = Setting.get_material!(id)

    case Setting.update_material(material, material_params) do
      {:ok, material} ->
        conn
        |> put_flash(:info, "Material updated successfully.")
        |> redirect(to: Routes.material_path(conn, :show, material))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", material: material, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    material = Setting.get_material!(id)
    {:ok, _material} = Setting.delete_material(material)

    conn
    |> put_flash(:info, "Material deleted successfully.")
    |> redirect(to: Routes.material_path(conn, :index))
  end
end
