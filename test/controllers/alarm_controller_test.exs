defmodule AppleStock.AlarmControllerTest do
  use AppleStock.ConnCase

  alias AppleStock.Alarm
  @valid_attrs %{part_id: "some content", postal_code: "some content", store_number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, alarm_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing alarms"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, alarm_path(conn, :new)
    assert html_response(conn, 200) =~ "New alarm"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, alarm_path(conn, :create), alarm: @valid_attrs
    assert redirected_to(conn) == alarm_path(conn, :index)
    assert Repo.get_by(Alarm, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, alarm_path(conn, :create), alarm: @invalid_attrs
    assert html_response(conn, 200) =~ "New alarm"
  end

  test "shows chosen resource", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = get conn, alarm_path(conn, :show, alarm)
    assert html_response(conn, 200) =~ "Show alarm"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, alarm_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = get conn, alarm_path(conn, :edit, alarm)
    assert html_response(conn, 200) =~ "Edit alarm"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = put conn, alarm_path(conn, :update, alarm), alarm: @valid_attrs
    assert redirected_to(conn) == alarm_path(conn, :show, alarm)
    assert Repo.get_by(Alarm, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = put conn, alarm_path(conn, :update, alarm), alarm: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit alarm"
  end

  test "deletes chosen resource", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = delete conn, alarm_path(conn, :delete, alarm)
    assert redirected_to(conn) == alarm_path(conn, :index)
    refute Repo.get(Alarm, alarm.id)
  end
end
