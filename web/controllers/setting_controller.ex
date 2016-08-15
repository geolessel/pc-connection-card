defmodule ConnectionCard.SettingController do
  use ConnectionCard.Web, :controller

  alias ConnectionCard.Setting

  plug :scrub_params, "setting" when action in [:update]

  def update(conn, %{"id" => setting_name, "setting" => setting_params}) do
    setting = Repo.get_by(Setting, name: setting_name)
    changeset = Setting.changeset(setting, setting_params)
    IO.inspect changeset

    case Repo.update(changeset) do
      {:ok, setting} ->
        render(conn, "show.json", setting: setting)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ConnectionCard.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
