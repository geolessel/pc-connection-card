defmodule ConnectionCard.Repo.Migrations.CreateSetting do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :name, :string
      add :value, :string

      timestamps
    end
  end
end
