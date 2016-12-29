defmodule AppleStock.AlarmController do
  use AppleStock.Web, :controller

  alias AppleStock.Alarm

  def index(conn, _params) do
    alarms = Repo.all(Alarm)
    render(conn, "index.html", alarms: alarms)
  end

  def new(conn, _params) do
    changeset = Alarm.changeset(%Alarm{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"alarm" => alarm_params}) do
    changeset = Alarm.changeset(%Alarm{}, alarm_params)

    case Repo.insert(changeset) do
      {:ok, alarm} ->
        AppleStock.AlarmEngine.register_alarm(alarm)
        conn
        |> put_flash(:info, "Alarm created successfully.")
        |> redirect(to: alarm_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)
    render(conn, "show.html", alarm: alarm)
  end

  def edit(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)
    changeset = Alarm.changeset(alarm)
    render(conn, "edit.html", alarm: alarm, changeset: changeset)
  end

  def update(conn, %{"id" => id, "alarm" => alarm_params}) do
    alarm = Repo.get!(Alarm, id)
    changeset = Alarm.changeset(alarm, alarm_params)

    case Repo.update(changeset) do
      {:ok, alarm} ->
        conn
        |> put_flash(:info, "Alarm updated successfully.")
        |> redirect(to: alarm_path(conn, :show, alarm))
      {:error, changeset} ->
        render(conn, "edit.html", alarm: alarm, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(alarm)
    AppleStock.AlarmEngine.deregister_alarm(id)

    conn
    |> put_flash(:info, "Alarm deleted successfully.")
    |> redirect(to: alarm_path(conn, :index))
  end
end
