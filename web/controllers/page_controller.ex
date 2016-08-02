defmodule ConnectionCard.PageController do
  use ConnectionCard.Web, :controller
  import Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def signup(conn, %{"person" => person} = params) do
    conn = put_flash(conn, :info, "#{person["first_name"]} #{person["last_name"]}")
    redirect conn, to: "/"
  end
end
