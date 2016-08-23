defmodule ConnectionCard.PageControllerTest do
  use ConnectionCard.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Connection Kiosk"
  end
end
