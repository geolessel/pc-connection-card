defmodule ConnectionCard.AdminView do
  use ConnectionCard.Web, :view

  def setting_value(settings, name) when is_list(settings) do
    settings
    |> Enum.find(&(&1.name == name))
    |> Map.get(:value)
  end

  def workflow_json(workflows) do
    workflows
    |> Enum.into([], &(%{name: &1.attributes["name"], id: &1.id}))
    |> Poison.encode!
  end
end
