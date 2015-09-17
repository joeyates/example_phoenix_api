defmodule PhoenixApi.ClimbController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.Climb

  plug :scrub_params, "climb" when action in [:create, :update]

  def index(conn, _params) do
    climbs = Repo.all(Climb)
    render(conn, "index.json", climbs: climbs)
  end

  def create(conn, %{"climb" => climb_params}) do
    changeset = Climb.changeset(%Climb{}, climb_params)

    if changeset.valid? do
      climb = Repo.insert!(changeset)
      render(conn, "show.json", climb: climb)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    climb = Repo.get!(Climb, id)
    render conn, "show.json", climb: climb
  end

  def update(conn, %{"id" => id, "climb" => climb_params}) do
    climb = Repo.get!(Climb, id)
    changeset = Climb.changeset(climb, climb_params)

    if changeset.valid? do
      climb = Repo.update!(changeset)
      render(conn, "show.json", climb: climb)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    climb = Repo.get!(Climb, id)

    climb = Repo.delete!(climb)
    render(conn, "show.json", climb: climb)
  end
end
