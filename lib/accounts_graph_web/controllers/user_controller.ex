defmodule AccountsGraphWeb.UserController do
  use AccountsGraphWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias AccountsGraphWeb.Schemas.{UserRequest, UserResponse}
  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true

  tags ["users"]
  security [%{}, %{"petstore_auth" => ["write:users", "read:users"]}]

  operation :update,
    summary: "Update user",
    parameters: [
      id: [in: :path, description: "User ID", type: :integer, example: 1001]
    ],
    request_body: {"User params", "application/json", UserRequest, required: true},
    responses: [
      ok: {"User response", "application/json", UserResponse}
    ]

  def update(conn, %{id: id}) do
    json(conn, %{
      data: %{
        id: id,
        name: "joe user",
        email: "joe@gmail.com"
      }
    })
  end
end
