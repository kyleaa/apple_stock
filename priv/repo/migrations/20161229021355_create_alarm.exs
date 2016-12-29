defmodule AppleStock.Repo.Migrations.CreateAlarm do
  use Ecto.Migration

  def change do
    create table(:alarms) do
      add :part_id, :string
      add :store_number, :string
      add :postal_code, :string

      timestamps()
    end

  end
end
