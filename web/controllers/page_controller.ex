defmodule ConnectionCard.PageController do
  use ConnectionCard.Web, :controller
  import Logger
  alias PcoApi.People.Person

  def index(conn, _params) do
    render conn, "index.html"
  end

  def signup(conn, %{"person" => person} = params) do
    %PcoApi.Record{attributes: attrs, id: id} =
      person
      |> Enum.into([], fn {k,v} -> {String.to_atom(k), v} end)
      |> Person.new
      |> Person.create
    conn = put_flash(conn, :info, "Created #{attrs["first_name"]} #{attrs["last_name"]} (ID #{id})")
    redirect conn, to: "/"
  end
end
