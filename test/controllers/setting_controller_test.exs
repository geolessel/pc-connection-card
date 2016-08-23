defmodule ConnectionCard.SettingControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.Setting
  @valid_attrs %{name: "some content", value: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    setting = Repo.insert! %Setting{name: "hi"}
    conn = put conn, setting_path(conn, :update, setting.name), setting: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Setting, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    setting = Repo.insert! %Setting{name: "hii"}
    conn = put conn, setting_path(conn, :update, setting.name), setting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
