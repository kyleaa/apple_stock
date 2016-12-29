defmodule AppleStock.AlarmEngine do
  alias AppleStock.{Alarm, Availability}
  @cache :alarm_cache

  require Logger

  def process_alarms do
    alarms
    |> Enum.each(fn key ->
      alarm = Cachex.get!(@cache, key)
      prior = alarm.available
      case Availability.available?(alarm) do
        ^prior -> nil
        false -> alarm |> Map.put(:available, false) |> cache_set(alarm.id)
        true ->
          send_notification("#{alarm.description} found in stock at #{alarm.store_number}")
          alarm |> Map.put(:available, true) |> cache_set(alarm.id)
      end
    end)
  end
  def register_all_alarms, do: AppleStock.Repo.all(Alarm) |> Enum.each(&register_alarm/1)

  def register_alarm(%Alarm{} = alarm) do
    alarm
    |> Map.put(:available, Availability.available?(alarm))
    |> cache_set(alarm.id)
    Logger.info "registered alarm #{alarm.id}"
  end
  def deregister_alarm(id) do
    Cachex.del(@cache, id)
    Logger.info "deregistered alarm #{id}"
  end

  def alarms do
    {:ok, keys} = Cachex.keys(@cache)
    keys
  end
  defp cache_set(value, key), do: Cachex.set(@cache, key, value)
  defp send_notification(text) do
    Logger.info "sending notification: #{inspect text}"
    ExAws.SNS.publish(text, target_arn: config(:target_arn)) |> ExAws.request!
  end
  defp config(key), do: Application.get_env(:apple_stock, __MODULE__)[key]

end
