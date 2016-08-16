defmodule ConnectionCard.Repo.Migrations.CreateOption do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :name, :string
      add :workflow_id, :integer

      timestamps
    end

  end
end
