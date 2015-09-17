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
end
