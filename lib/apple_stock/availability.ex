defmodule AppleStock.Availability do
  alias Poison, as: JSON
  require Logger

  def fetch_availability(part_number, zip) when is_bitstring(part_number), do: fetch_availability([%{number: part_number}], zip)
  def fetch_availability(parts, zip) when is_list(parts) do
    parts = parts
    |> Enum.with_index
    |> Enum.map(fn {map, i} -> Map.get(map, :number) |> part_url_param(i) end)
    |> Enum.join("&")
    url = "http://www.apple.com/shop/retail/pickup-message?location=#{zip}&#{parts}"
    Logger.debug "url: #{url}"
    HTTPoison.get!(url)
    |> extract_struct_body
    |> JSON.decode!
    |> extract_body
  end

  def available?(%{"partsAvailability" => availability}, partname), do: availability[partname]["pickupDisplay"] == "available"
  def available?(nil, _partname), do: false

  def available?(%AppleStock.Alarm{} = alarm) do
    fetch_availability(alarm.part_id, alarm.postal_code)
    |> Kernel.get_in(["stores"])
    |> Enum.find(fn store ->
      Kernel.get_in(store, ["storeNumber"]) == alarm.store_number
    end)
    |> available?(alarm.part_id)
  end

  defp part_url_param(n, i), do: "parts.#{i}=#{n}"
  def extract_body(m) when is_map(m), do: m |> Map.get("body")
  def extract_struct_body(s), do: s.body
end
