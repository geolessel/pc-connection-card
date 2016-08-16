defmodule ConnectionCard.PageController do
  use ConnectionCard.Web, :controller

  alias ConnectionCard.{Repo, Option}
  alias PcoApi.People.{Person, Email, PhoneNumber, Address}
  alias PcoApi.People.Workflow
  alias PcoApi.People.Workflow.Card

  def index(conn, _params) do
    options = Repo.all from o in Option, select: %{name: o.name, workflow_id: o.workflow_id}
    IO.inspect options
    render conn, "index.html", options: options
  end

  def signup(conn, %{"person" => person_params, "interests" => interests}) do
    record =
      person_params
      |> Enum.into([], fn {k,v} -> {String.to_atom(k), v} end)
      |> filter_person_params()
      |> Person.new()
      |> Person.create()
      |> create_contact_methods(person_params)
      |> add_to_workflows(interests)

    put_flash(
      conn,
      :info,
      "Created #{record.attributes["first_name"]} #{record.attributes["last_name"]} (ID #{record.id})")
    |> redirect to: "/"
  end

  defp create_contact_methods(person, params) do
    # TODO: make these async
    create_email(person, params)
    create_phone(person, params)
    create_address(person, params)

    person
  end

  defp create_email(_, %{"email" => ""}), do: :noop
  defp create_email(person, %{"email" => email}) do
    email = Email.new(location: "home", address: email)
    person
    |> Email.create(email)
  end

  defp create_phone(_, %{"phone" => ""}), do: :noop
  defp create_phone(person, %{"phone" => phone}) do
    phone = PhoneNumber.new(location: "home", number: phone)
    person
    |> PhoneNumber.create(phone)
  end

  defp create_address(person, params) do
    if required_address_params_present? params do
      address = Address.new(location: "home", street: params["street"], city: params["city"], state: params["state"], zip: params["zip"])
      person
      |> Address.create(address)
    end
  end
  defp required_address_params_present?(params) do
    ["street", "city", "state", "zip"]
    |> Enum.all?(&(String.length(params[&1]) > 0))
  end

  defp add_to_workflows(person, interests) do
    card = Card.new(person_id: person.id)
    interests
    |> Enum.into([])
    |> Enum.each(fn interest ->
                  case interest do
                    {id, "true"} ->
                      # TODO: change either this or the API wrapper. This requires inside knowledge of pco_api to make this work.
                      # TODO: make these async
                      Card.create(%PcoApi.Record{type: "Workflow", id: id}, card)
                    {_, "false"} -> :noop
                  end
                end)
    person
  end

  def filter_person_params(person) do
    whitelist = ~w(first_name last_name)a
    person
    |> Enum.filter(fn {k,v} -> k in whitelist end)
  end
end
