defmodule AccountsGraphWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom
  import_types AccountsGraphWeb.Schema.AccountsTypes

  alias AccountsGraphWeb.Resolvers

  mutation do
    @desc "Create a new user"
    field :create_user, :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.create_user/3
    end
  end

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolvers.Accounts.list_users/3
    end

    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.find_user/3
    end
  end

end