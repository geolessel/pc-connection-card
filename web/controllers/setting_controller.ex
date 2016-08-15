defmodule ConnectionCard.SettingController do
  use ConnectionCard.Web, :controller

  alias ConnectionCard.Setting

  plug :scrub_params, "setting" when action in [:create, :update]

  def index(conn, _params) do
    settings = Repo.all(Setting)
    render(conn, "index.json", settings: settings)
  end

  def create(conn, %{"setting" => setting_params}) do
    changeset = Setting.changeset(%Setting{}, setting_params)

    case Repo.insert(changeset) do
      {:ok, setting} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", setting_path(conn, :show, setting))
        |> render("show.json", setting: setting)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ConnectionCard.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    setting = Repo.get!(Setting, id)
    render(conn, "show.json", setting: setting)
  end

  def update(conn, %{"id" => id, "setting" => setting_params}) do
    setting = Repo.get!(Setting, id)
    changeset = Setting.changeset(setting, setting_params)

    case Repo.update(changeset) do
      {:ok, setting} ->
        render(conn, "show.json", setting: setting)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ConnectionCard.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    setting = Repo.get!(Setting, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(setting)

    send_resp(conn, :no_content, "")
  end
end
