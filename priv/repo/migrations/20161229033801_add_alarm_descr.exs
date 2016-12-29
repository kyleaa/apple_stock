defmodule AppleStock.Repo.Migrations.AddAlarmDescr do
  use Ecto.Migration

  def change do
    alter table(:alarms) do
      add :description, :string
    end
  end
end
