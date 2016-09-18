defmodule AppleStock.DashboardTest do
  use AppleStock.ModelCase

  alias AppleStock.Dashboard

  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dashboard.changeset(%Dashboard{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dashboard.changeset(%Dashboard{}, @invalid_attrs)
    refute changeset.valid?
  end
end
