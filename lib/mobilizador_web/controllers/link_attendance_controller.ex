defmodule MobilizadorWeb.LinkAttendanceController do
  use MobilizadorWeb, :controller

  alias Mobilizador.Url
  alias Mobilizador.Url.LinkAttendance

  def show(conn, %{"id" => id}) do
    link = Url.get_link_attendance!(id)
    redirect(conn, external: link.url)
  end
end
