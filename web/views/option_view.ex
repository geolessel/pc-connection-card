defmodule ConnectionCard.OptionView do
  use ConnectionCard.Web, :view

  def render("index.json", %{options: options}) do
    %{data: render_many(options, ConnectionCard.OptionView, "option.json")}
  end

  def render("show.json", %{option: option}) do
    %{data: render_one(option, ConnectionCard.OptionView, "option.json")}
  end

  def render("option.json", %{option: option}) do
    %{id: option.id,
      name: option.name,
      workflow_id: option.workflow_id}
  end
end
