defmodule ConnectionCard.Option do
  use ConnectionCard.Web, :model

  schema "options" do
    field :name, :string
    field :workflow_id, :integer

    timestamps
  end

  @required_fields ~w(name workflow_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
