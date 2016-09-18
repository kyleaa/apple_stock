defmodule AppleStock.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts) do
      add :number, :string
      add :description, :string

      timestamps()
    end

  end
end
