defmodule AccountsGraph.Repo do
  use Ecto.Repo,
    otp_app: :accounts_graph,
    adapter: Ecto.Adapters.Postgres
end
