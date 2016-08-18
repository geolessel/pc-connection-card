defmodule ConnectionCard.OptionTest do
  use ConnectionCard.ModelCase

  alias ConnectionCard.Option

  @valid_attrs %{name: "some content", workflow_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Option.changeset(%Option{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Option.changeset(%Option{}, @invalid_attrs)
    refute changeset.valid?
  end
end
