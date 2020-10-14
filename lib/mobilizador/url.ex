defmodule Mobilizador.Url do
  @moduledoc """
  The Url context.
  """

  import Ecto.Query, warn: false
  alias Mobilizador.Repo

  alias Mobilizador.Url.LinkAttendance

  @doc """
  Returns the list of link_attendances.

  ## Examples

      iex> list_link_attendances()
      [%LinkAttendance{}, ...]

  """
  def list_link_attendances do
    Repo.all(LinkAttendance)
  end

  @doc """
  Gets a single link_attendance.

  Raises `Ecto.NoResultsError` if the Link attendance does not exist.

  ## Examples

      iex> get_link_attendance!(123)
      %LinkAttendance{}

      iex> get_link_attendance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link_attendance!(id), do: Repo.get!(LinkAttendance, id)

  @doc """
  Creates a link_attendance.

  ## Examples

      iex> create_link_attendance(%{field: value})
      {:ok, %LinkAttendance{}}

      iex> create_link_attendance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link_attendance(attrs \\ %{}) do
    %LinkAttendance{}
    |> LinkAttendance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link_attendance.

  ## Examples

      iex> update_link_attendance(link_attendance, %{field: new_value})
      {:ok, %LinkAttendance{}}

      iex> update_link_attendance(link_attendance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link_attendance(%LinkAttendance{} = link_attendance, attrs) do
    link_attendance
    |> LinkAttendance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link_attendance.

  ## Examples

      iex> delete_link_attendance(link_attendance)
      {:ok, %LinkAttendance{}}

      iex> delete_link_attendance(link_attendance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link_attendance(%LinkAttendance{} = link_attendance) do
    Repo.delete(link_attendance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link_attendance changes.

  ## Examples

      iex> change_link_attendance(link_attendance)
      %Ecto.Changeset{source: %LinkAttendance{}}

  """
  def change_link_attendance(%LinkAttendance{} = link_attendance) do
    LinkAttendance.changeset(link_attendance, %{})
  end
end
