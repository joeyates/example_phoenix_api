defmodule PhoenixApi.ClimbControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.Climb
  @valid_attrs %{finish: 42, length: "120.5", name: "some content", start: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    climb = Repo.insert! %Climb{}
    conn = get conn, climb_path(conn, :index)
    json = json_response(conn, 200)
    ids = Enum.map(json["data"], fn (c) -> c["id"] end)
    assert ids == [climb.id]
  end

  test "shows chosen resource", %{conn: conn} do
    climb = Repo.insert! %Climb{}
    conn = get conn, climb_path(conn, :show, climb)
    json = json_response(conn, 200)
    assert json["data"]["id"] == climb.id
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, climb_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, climb_path(conn, :create), climb: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Climb, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, climb_path(conn, :create), climb: @invalid_attrs
    response = json_response(conn, 422)
    assert response["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    climb = Repo.insert! %Climb{}
    conn = put conn, climb_path(conn, :update, climb), climb: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Climb, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    climb = Repo.insert! %Climb{}
    conn = put conn, climb_path(conn, :update, climb), climb: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    climb = Repo.insert! %Climb{}
    conn = delete conn, climb_path(conn, :delete, climb)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Climb, climb.id)
  end
end
