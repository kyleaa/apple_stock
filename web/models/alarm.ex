defmodule AppleStock.Alarm do
  use AppleStock.Web, :model

  schema "alarms" do
    field :part_id, :string
    field :store_number, :string
    field :postal_code, :string
    field :description, :string
    field :available, :boolean, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:part_id, :store_number, :postal_code, :description])
    |> validate_required([:part_id, :store_number, :postal_code, :description])
  end
end
