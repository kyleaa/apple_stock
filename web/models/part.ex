defmodule AppleStock.Part do
  use AppleStock.Web, :model

  schema "parts" do
    field :number, :string
    field :description, :string
    belongs_to :dashboard, AppleStock.Dashboard

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number, :description, :dashboard_id])
    |> validate_required([:number, :description, :dashboard_id])
  end
end
