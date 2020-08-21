defmodule AccountsGraphWeb.PageController do
  use AccountsGraphWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
