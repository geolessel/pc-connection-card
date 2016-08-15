defmodule ConnectionCard.AdminController do
  use ConnectionCard.Web, :controller
  import Logger

  def index(conn, _params) do
    settings = ConnectionCard.Repo.all ConnectionCard.Setting
    render conn, "index.html", settings: settings
  end
end
