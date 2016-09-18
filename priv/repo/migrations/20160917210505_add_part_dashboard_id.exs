defmodule AppleStock.Repo.Migrations.AddPartDashboardId do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      add :dashboard_id, references(:dashboards)
    end
  end
end
