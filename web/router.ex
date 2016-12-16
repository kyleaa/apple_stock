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
    resources "/admin/parts/", PartController
    resources "/admin/dashboards/", DashboardController, except: [:show]
    
    get "/", PageController, :index
    get "/:id", DashboardController, :show
    get "/:id/:zip", DashboardController, :show
  end

end
