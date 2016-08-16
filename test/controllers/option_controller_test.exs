defmodule ConnectionCard.OptionControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.Option
  @valid_attrs %{name: "some content", workflow_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, option_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = get conn, option_path(conn, :show, option)
    assert json_response(conn, 200)["data"] == %{"id" => option.id,
      "name" => option.name,
      "workflow_id" => option.workflow_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, option_path(conn, :show, -1)
    end
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

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = put conn, option_path(conn, :update, option), option: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Option, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = put conn, option_path(conn, :update, option), option: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = delete conn, option_path(conn, :delete, option)
    assert response(conn, 204)
    refute Repo.get(Option, option.id)
  end
end
