defmodule ConnectionCard.PageController do
  use ConnectionCard.Web, :controller
  import Logger
  alias PcoApi.People.{Person, Email, PhoneNumber}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def signup(conn, %{"person" => person} = params) do
    record =
      person
      |> Enum.into([], fn {k,v} -> {String.to_atom(k), v} end)
      |> filter_person_params
      |> Person.new
      |> Person.create
      |> create_contact_methods(person)

    conn = put_flash(conn, :info, "Created #{record.attributes["first_name"]} #{record.attributes["last_name"]} (ID #{record.id})")
    redirect conn, to: "/"
  end

  defp create_contact_methods(person, params) do
    create_email(person, params)
    create_phone(person, params)

    person
  end

  defp create_email(person, params) do
    email = Email.new(location: "home", address: params["email"])
    person
    |> Email.create(email)
  end

  defp create_phone(person, params) do
    phone = PhoneNumber.new(location: "home", number: params["phone"])
    person
    |> PhoneNumber.create(phone)
  end

  def filter_person_params(person) do
    whitelist = ~w(first_name last_name)a
    person
    |> Enum.filter(fn {k,v} -> k in whitelist end)
  end
end
