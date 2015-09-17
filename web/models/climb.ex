defmodule PhoenixApi.Climb do
  use PhoenixApi.Web, :model

  schema "climbs" do
    field :name, :string
    field :length, :float
    field :start, :integer
    field :finish, :integer

    timestamps
  end

  @required_fields ~w(name length start finish)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

defimpl Poison.Encoder, for: PhoenixApi.Climb do
  def encode(climb, _options) do
    %{
      id: climb.id,
      name: climb.name,
    } |> Poison.Encoder.encode([])
  end
end
