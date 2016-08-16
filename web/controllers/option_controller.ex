defmodule ConnectionCard.OptionController do
  use ConnectionCard.Web, :controller

  alias ConnectionCard.Option

  plug :scrub_params, "option" when action in [:create]

  def create(conn, %{"option" => option_params}) do
    changeset = Option.changeset(%Option{}, option_params)

    case Repo.insert(changeset) do
      {:ok, option} ->
        conn
        |> put_status(:created)
        # |> put_resp_header("location", option_path(conn, :show, option))
        |> render("show.json", option: option)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ConnectionCard.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option)

    send_resp(conn, :no_content, "")
  end
end
