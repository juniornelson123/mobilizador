defmodule Mobilizador.AttendanceTest do
  use Mobilizador.DataCase

  alias Mobilizador.Attendance

  describe "leads" do
    alias Mobilizador.Attendance.Lead

    @valid_attrs %{date_attendance: "some date_attendance", name: "some name", phone: "some phone"}
    @update_attrs %{date_attendance: "some updated date_attendance", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{date_attendance: nil, name: nil, phone: nil}

    def lead_fixture(attrs \\ %{}) do
      {:ok, lead} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Attendance.create_lead()

      lead
    end

    test "list_leads/0 returns all leads" do
      lead = lead_fixture()
      assert Attendance.list_leads() == [lead]
    end

    test "get_lead!/1 returns the lead with given id" do
      lead = lead_fixture()
      assert Attendance.get_lead!(lead.id) == lead
    end

    test "create_lead/1 with valid data creates a lead" do
      assert {:ok, %Lead{} = lead} = Attendance.create_lead(@valid_attrs)
      assert lead.date_attendance == "some date_attendance"
      assert lead.name == "some name"
      assert lead.phone == "some phone"
    end

    test "create_lead/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendance.create_lead(@invalid_attrs)
    end

    test "update_lead/2 with valid data updates the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{} = lead} = Attendance.update_lead(lead, @update_attrs)
      assert lead.date_attendance == "some updated date_attendance"
      assert lead.name == "some updated name"
      assert lead.phone == "some updated phone"
    end

    test "update_lead/2 with invalid data returns error changeset" do
      lead = lead_fixture()
      assert {:error, %Ecto.Changeset{}} = Attendance.update_lead(lead, @invalid_attrs)
      assert lead == Attendance.get_lead!(lead.id)
    end

    test "delete_lead/1 deletes the lead" do
      lead = lead_fixture()
      assert {:ok, %Lead{}} = Attendance.delete_lead(lead)
      assert_raise Ecto.NoResultsError, fn -> Attendance.get_lead!(lead.id) end
    end

    test "change_lead/1 returns a lead changeset" do
      lead = lead_fixture()
      assert %Ecto.Changeset{} = Attendance.change_lead(lead)
    end
  end
end
