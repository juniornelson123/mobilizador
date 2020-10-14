defmodule MobilizadorWeb.PageController do
  use MobilizadorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
