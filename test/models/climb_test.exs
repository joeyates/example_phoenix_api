defmodule PhoenixApi.ClimbTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.Climb

  @valid_attrs %{name: "A climb", start: 20, finish: 500, length: 12050.5}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Climb.changeset(%Climb{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Climb.changeset(%Climb{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "finish must be greater than start" do
    downhill = Map.merge(@valid_attrs, %{start: 1000})
    assert {:finish, "must be greater than start"} in errors_on(%Climb{}, downhill)
  end

  test "length must be positive" do
    backwards = Map.merge(@valid_attrs, %{length: -500})
    assert {:length, {"must be greater than zero", 0}} in errors_on(%Climb{}, backwards)
  end

  test "rise returns metres gained" do
    climb = %Climb{start: 45, finish: 93}
    assert Climb.rise(climb) == 48
  end

  test "gradient returns average steepness as a percentage" do
    climb = %Climb{start: 45, finish: 950, length: 8300}
    assert_in_delta(Climb.gradient(climb), 10.9, 0.1)
  end

  test "difficulty is the square of the gradient times the length in km" do
    climb = %Climb{start: 45, finish: 950, length: 8300}
    assert Climb.difficulty(climb) == 987
  end

  test "JSON includes name" do
    climb = Repo.insert!(Climb.changeset(%Climb{}, @valid_attrs))
    assert json_data(climb)["name"] == climb.name
  end

  test "JSON includes gradient" do
    climb = Repo.insert!(Climb.changeset(%Climb{}, @valid_attrs))
    assert json_data(climb)["gradient"] == Climb.gradient(climb)
  end

  test "JSON includes difficulty" do
    climb = Repo.insert!(Climb.changeset(%Climb{}, @valid_attrs))
    assert json_data(climb)["difficulty"] == Climb.difficulty(climb)
  end
end
