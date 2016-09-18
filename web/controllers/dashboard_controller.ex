defmodule AppleStock.DashboardController do
  use AppleStock.Web, :controller
  alias AppleStock.{Repo}
  alias Poison, as: JSON
  require Logger

  alias AppleStock.Dashboard

  def index(conn, _params) do
    dashboards = Repo.all(Dashboard)
    render(conn, "index.html", dashboards: dashboards)
  end

  def new(conn, _params) do
    changeset = Dashboard.changeset(%Dashboard{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dashboard" => dashboard_params}) do
    changeset = Dashboard.changeset(%Dashboard{}, dashboard_params)

    case Repo.insert(changeset) do
      {:ok, _dashboard} ->
        conn
        |> put_flash(:info, "Dashboard created successfully.")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dashboard = Repo.get!(Dashboard, id)
    |> Repo.preload(:parts)
    availability = fetch_availability(dashboard.parts)
    Logger.debug "#{inspect availability}"
    render(conn, "show.html", dashboard: dashboard, availability: availability)
  end

  def edit(conn, %{"id" => id}) do
    dashboard = Repo.get!(Dashboard, id)
    changeset = Dashboard.changeset(dashboard)
    render(conn, "edit.html", dashboard: dashboard, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dashboard" => dashboard_params}) do
    dashboard = Repo.get!(Dashboard, id)
    changeset = Dashboard.changeset(dashboard, dashboard_params)

    case Repo.update(changeset) do
      {:ok} ->
        conn
        |> put_flash(:info, "Dashboard updated successfully.")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", dashboard: dashboard, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dashboard = Repo.get!(Dashboard, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(dashboard)

    conn
    |> put_flash(:info, "Dashboard deleted successfully.")
    |> redirect(to: dashboard_path(conn, :index))
  end

  def fetch_availability(parts) do
    parts = parts
    |> Enum.with_index
    |> Enum.map(fn {map, i} -> Map.get(map, :number) |> part_url_param(i) end)
    |> Enum.join("&")
    url = "http://www.apple.com/shop/retail/pickup-message?location=14094&#{parts}"
    Logger.debug "url: #{url}"
    HTTPoison.get!(url)
    |> extract_struct_body
    |> JSON.decode!
    |> extract_body
  end

  defp part_url_param(n, i), do: "parts.#{i}=#{n}"
  def extract_body(m) when is_map(m), do: m |> Map.get("body")
  def extract_struct_body(s), do: s.body
end
