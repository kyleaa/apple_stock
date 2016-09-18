defmodule AppleStock.PageController do
  use AppleStock.Web, :controller
  alias AppleStock.Dashboard

  def index(conn, _params) do
    dashboards = Repo.all(Dashboard)
    render(conn, "index.html", dashboards: dashboards)
  end

end
