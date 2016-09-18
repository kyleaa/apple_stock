defmodule AppleStock.Router do
  use AppleStock.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", AppleStock do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/:id", DashboardController, :show
    resources "/admin/parts", PartController
    resources "/admin/dashboards", DashboardController, except: [:show]
  end

end
