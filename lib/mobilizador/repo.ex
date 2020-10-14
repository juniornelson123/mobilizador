defmodule Mobilizador.Repo do
  use Ecto.Repo,
    otp_app: :mobilizador,
    adapter: Ecto.Adapters.Postgres
end
