defmodule Ukio.Bookings.Handlers.BookingService do
  alias Ukio.Bookings

  @doc """
  @deprecated
  Check booking availability. Deprecated due to:
    - we need to parse/convert input
    - more efficient on repo layer
  Moved to repo layer
  """
  def check_booking_availability(apartment_id, check_in, check_out) do
    IO.inspect(apartment_id)
    dcheck_in = Date.from_iso8601!(check_in)
    dcheck_out = Date.from_iso8601!(check_out)
    IO.inspect(dcheck_out)

    Bookings.get_booking_by_apartment(apartment_id)
    |> Enum.filter(fn x ->
      (x.check_in <= dcheck_in and x.check_out >= dcheck_out) or
      (x.check_in >= dcheck_in and x.check_in < dcheck_out) or
      (x.check_out <= dcheck_out and x.check_out > dcheck_in) end)
    |> Enum.empty?()
  end

  def is_booking_slot_available?(apartment_id, check_in, check_out) do
    Bookings.check_booking_slot(apartment_id, check_in, check_out) |> Enum.empty?()
  end
end
