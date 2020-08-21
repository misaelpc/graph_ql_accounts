defmodule AccountsGraphWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string
    field :password, :string
  end
end
