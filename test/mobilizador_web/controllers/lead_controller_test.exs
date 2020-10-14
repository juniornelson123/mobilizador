defmodule MobilizadorWeb.LeadControllerTest do
  use MobilizadorWeb.ConnCase

  alias Mobilizador.Attendance

  @create_attrs %{date_attendance: "some date_attendance", name: "some name", phone: "some phone"}
  @update_attrs %{date_attendance: "some updated date_attendance", name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{date_attendance: nil, name: nil, phone: nil}

  def fixture(:lead) do
    {:ok, lead} = Attendance.create_lead(@create_attrs)
    lead
  end

  describe "index" do
    test "lists all leads", %{conn: conn} do
      conn = get(conn, Routes.lead_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Leads"
    end
  end

  describe "new lead" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.lead_path(conn, :new))
      assert html_response(conn, 200) =~ "New Lead"
    end
  end

  describe "create lead" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.lead_path(conn, :create), lead: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.lead_path(conn, :show, id)

      conn = get(conn, Routes.lead_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Lead"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.lead_path(conn, :create), lead: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Lead"
    end
  end

  describe "edit lead" do
    setup [:create_lead]

    test "renders form for editing chosen lead", %{conn: conn, lead: lead} do
      conn = get(conn, Routes.lead_path(conn, :edit, lead))
      assert html_response(conn, 200) =~ "Edit Lead"
    end
  end

  describe "update lead" do
    setup [:create_lead]

    test "redirects when data is valid", %{conn: conn, lead: lead} do
      conn = put(conn, Routes.lead_path(conn, :update, lead), lead: @update_attrs)
      assert redirected_to(conn) == Routes.lead_path(conn, :show, lead)

      conn = get(conn, Routes.lead_path(conn, :show, lead))
      assert html_response(conn, 200) =~ "some updated date_attendance"
    end

    test "renders errors when data is invalid", %{conn: conn, lead: lead} do
      conn = put(conn, Routes.lead_path(conn, :update, lead), lead: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Lead"
    end
  end

  describe "delete lead" do
    setup [:create_lead]

    test "deletes chosen lead", %{conn: conn, lead: lead} do
      conn = delete(conn, Routes.lead_path(conn, :delete, lead))
      assert redirected_to(conn) == Routes.lead_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.lead_path(conn, :show, lead))
      end
    end
  end

  defp create_lead(_) do
    lead = fixture(:lead)
    {:ok, lead: lead}
  end
end
