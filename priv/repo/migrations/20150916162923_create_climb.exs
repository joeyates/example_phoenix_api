defmodule PhoenixApi.Repo.Migrations.CreateClimb do
  use Ecto.Migration

  def change do
    create table(:climbs) do
      add :name, :string
      add :length, :float
      add :start, :integer
      add :finish, :integer

      timestamps
    end

  end
end
