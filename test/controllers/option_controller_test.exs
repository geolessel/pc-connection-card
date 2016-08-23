defmodule ConnectionCard.OptionControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.Option
  @valid_attrs %{name: "some content", workflow_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, option_path(conn, :create), option: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Option, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, option_path(conn, :create), option: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = delete conn, option_path(conn, :delete, option)
    assert response(conn, 204)
    refute Repo.get(Option, option.id)
  end
end
