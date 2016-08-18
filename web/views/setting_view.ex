defmodule ConnectionCard.SettingView do
  use ConnectionCard.Web, :view

  def render("index.json", %{settings: settings}) do
    %{data: render_many(settings, ConnectionCard.SettingView, "setting.json")}
  end

  def render("show.json", %{setting: setting}) do
    %{data: render_one(setting, ConnectionCard.SettingView, "setting.json")}
  end

  def render("setting.json", %{setting: setting}) do
    %{id: setting.id,
      name: setting.name,
      value: setting.value}
  end
end
