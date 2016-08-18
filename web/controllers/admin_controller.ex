defmodule ConnectionCard.AdminController do
  use ConnectionCard.Web, :controller
  import Logger

  alias ConnectionCard.{Repo, Setting, Option}

  def index(conn, _params) do
    # TODO: make Setting load like Option
    settings  = Repo.all Setting
    options   = Repo.all from o in Option, select: %{id: o.id, name: o.name, workflow_id: o.workflow_id}
    workflows = PcoApi.People.Workflow.list
    render conn, "index.html", settings: settings, workflows: workflows, options: options
  end
end
