defmodule AppleStock.Repo.Migrations.CreateDashboard do
  use Ecto.Migration

  def change do
    create table(:dashboards) do
      add :description, :string

      timestamps()
    end

  end
end
