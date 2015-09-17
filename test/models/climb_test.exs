defmodule PhoenixApi.ClimbTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.Climb

  @valid_attrs %{finish: 42, length: "120.5", name: "some content", start: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Climb.changeset(%Climb{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Climb.changeset(%Climb{}, @invalid_attrs)
    refute changeset.valid?
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
end
