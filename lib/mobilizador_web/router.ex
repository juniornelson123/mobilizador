defmodule MobilizadorWeb.Router do
  use MobilizadorWeb, :router
  use Pow.Phoenix.Router

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", MobilizadorWeb do
    pipe_through :browser

    resources "/link_attedance", LinkAttendanceController
  end
  
  scope "/admin", MobilizadorWeb.Admin do
    pipe_through [:browser, :protected]

    resources "/supervisor", SupervisorController
    resources "/mobilizador", MobilizadorController
    resources "/leads", LeadController
  end
  
  scope "/mobilizador", MobilizadorWeb.Mobilizador do
    pipe_through [:browser, :protected]

    resources "/leads", LeadController, as: :mobilizador_lead
  end
  
  scope "/supervisor", MobilizadorWeb.Supervisor do
    pipe_through [:browser, :protected]

    resources "/leads", LeadController, as: :supervisor_lead
    resources "/mobilizador", MobilizadorController, as: :supervisor_mobilizador
  end

  scope "/", MobilizadorWeb do
    pipe_through [:browser, :protected]
    
    get "/", PageController, :index
    resources "/admins", AdminController
    resources "/leads", LeadController
    resources "/topics", MaterialController
    resources "/materials", MaterialController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MobilizadorWeb do
  #   pipe_through :api
  # end
end
