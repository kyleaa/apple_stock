defmodule AppleStock.Dashboard do
  use AppleStock.Web, :model

  schema "dashboards" do
    field :description, :string
    has_many :parts, AppleStock.Part

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
