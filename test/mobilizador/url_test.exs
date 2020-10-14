defmodule Mobilizador.UrlTest do
  use Mobilizador.DataCase

  alias Mobilizador.Url

  describe "link_attendances" do
    alias Mobilizador.Url.LinkAttendance

    @valid_attrs %{name_prospect: "some name_prospect", token: "some token", url: "some url"}
    @update_attrs %{name_prospect: "some updated name_prospect", token: "some updated token", url: "some updated url"}
    @invalid_attrs %{name_prospect: nil, token: nil, url: nil}

    def link_attendance_fixture(attrs \\ %{}) do
      {:ok, link_attendance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Url.create_link_attendance()

      link_attendance
    end

    test "list_link_attendances/0 returns all link_attendances" do
      link_attendance = link_attendance_fixture()
      assert Url.list_link_attendances() == [link_attendance]
    end

    test "get_link_attendance!/1 returns the link_attendance with given id" do
      link_attendance = link_attendance_fixture()
      assert Url.get_link_attendance!(link_attendance.id) == link_attendance
    end

    test "create_link_attendance/1 with valid data creates a link_attendance" do
      assert {:ok, %LinkAttendance{} = link_attendance} = Url.create_link_attendance(@valid_attrs)
      assert link_attendance.name_prospect == "some name_prospect"
      assert link_attendance.token == "some token"
      assert link_attendance.url == "some url"
    end

    test "create_link_attendance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Url.create_link_attendance(@invalid_attrs)
    end

    test "update_link_attendance/2 with valid data updates the link_attendance" do
      link_attendance = link_attendance_fixture()
      assert {:ok, %LinkAttendance{} = link_attendance} = Url.update_link_attendance(link_attendance, @update_attrs)
      assert link_attendance.name_prospect == "some updated name_prospect"
      assert link_attendance.token == "some updated token"
      assert link_attendance.url == "some updated url"
    end

    test "update_link_attendance/2 with invalid data returns error changeset" do
      link_attendance = link_attendance_fixture()
      assert {:error, %Ecto.Changeset{}} = Url.update_link_attendance(link_attendance, @invalid_attrs)
      assert link_attendance == Url.get_link_attendance!(link_attendance.id)
    end

    test "delete_link_attendance/1 deletes the link_attendance" do
      link_attendance = link_attendance_fixture()
      assert {:ok, %LinkAttendance{}} = Url.delete_link_attendance(link_attendance)
      assert_raise Ecto.NoResultsError, fn -> Url.get_link_attendance!(link_attendance.id) end
    end

    test "change_link_attendance/1 returns a link_attendance changeset" do
      link_attendance = link_attendance_fixture()
      assert %Ecto.Changeset{} = Url.change_link_attendance(link_attendance)
    end
  end
end
