defmodule AppleStock.AdminLandingController do
  use AppleStock.Web, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end

end
