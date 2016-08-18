defmodule ConnectionCard.Router do
  use ConnectionCard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConnectionCard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/signup", PageController, :signup
  end

  scope "/admin", ConnectionCard do
    pipe_through :browser

    get "/", AdminController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ConnectionCard do
    pipe_through :api

    resources "/settings", SettingController, only: [:update]
    resources "/options", OptionController, only: [:create, :delete]
  end
end
