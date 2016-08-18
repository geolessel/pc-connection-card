defmodule ConnectionCard.SettingControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.Setting
  @valid_attrs %{name: "some content", value: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, setting_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = get conn, setting_path(conn, :show, setting)
    assert json_response(conn, 200)["data"] == %{"id" => setting.id,
      "name" => setting.name,
      "value" => setting.value}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, setting_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, setting_path(conn, :create), setting: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Setting, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, setting_path(conn, :create), setting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = put conn, setting_path(conn, :update, setting), setting: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Setting, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = put conn, setting_path(conn, :update, setting), setting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    setting = Repo.insert! %Setting{}
    conn = delete conn, setting_path(conn, :delete, setting)
    assert response(conn, 204)
    refute Repo.get(Setting, setting.id)
  end
end
