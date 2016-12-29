defmodule AppleStock.AlarmTest do
  use AppleStock.ModelCase

  alias AppleStock.Alarm

  @valid_attrs %{part_id: "some content", postal_code: "some content", store_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Alarm.changeset(%Alarm{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Alarm.changeset(%Alarm{}, @invalid_attrs)
    refute changeset.valid?
  end
end
