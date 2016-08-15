defmodule ConnectionCard.AdminController do
  use ConnectionCard.Web, :controller
  import Logger

  def index(conn, _params) do
    render conn, "index.html"
  end
end
