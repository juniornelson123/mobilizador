# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mobilizador.Repo.insert!(%Mobilizador.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Pow.Ecto.Context.create(%{name: "Admin", kind: "admin", phone: "86995625927", email: "admin@admin.com", password_confirmation: "12345678", password: "12345678"}, [user: Mobilizador.Users.User, repo: Mobilizador.Repo ])
{:ok, user} = Pow.Ecto.Context.create(%{name: "Elias", kind: "supervisor", phone: "86995625927", email: "elias@gmail.com", password_confirmation: "12345678", password: "12345678"}, [user: Mobilizador.Users.User, repo: Mobilizador.Repo ])
Pow.Ecto.Context.create(%{name: "Junior", kind: "mobilizador", phone: "86995625927", parent_id: user.id, email: "junior@gmail.com", password_confirmation: "12345678", password: "12345678"}, [user: Mobilizador.Users.User, repo: Mobilizador.Repo ])