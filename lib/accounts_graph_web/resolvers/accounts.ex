defmodule AccountsGraphWeb.Resolvers.Accounts do
  alias AccountsGraph.Accounts

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def create_user(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Accounts.create_user(args) do
      {:ok, user} ->
        {:ok, user}
      _error ->
        {:error, "could not create user"}
    end
  end

  def find_user(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Accounts.get_user(args) do
      {:ok, user} ->
        {:ok, user}
      _error ->
        {:error, "could not create user"}
    end
  end
end
