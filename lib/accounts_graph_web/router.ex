defmodule AccountsGraphWeb.Router do
  use AccountsGraphWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: AccountsGraphWeb.ApiSpec
  end

  scope "/" do
    pipe_through :browser

    get "/", AccountsGraphWeb.PageController, :index
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/api/v1/openapi"
  end

  scope "/api/v1" do
    pipe_through :api
    resources "/users", AccountsGraphWeb.UserController, only: [:update]
    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: AccountsGraphWeb.Schema,
      interface: :simple

    forward "/", Absinthe.Plug,
      schema: AccountsGraphWeb.Schema

  end

  # Other scopes may use custom stacks.
  # scope "/api", AccountsGraphWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AccountsGraphWeb.Telemetry
    end
  end
end
