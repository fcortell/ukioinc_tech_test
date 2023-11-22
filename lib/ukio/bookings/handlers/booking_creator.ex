defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Bookings
  alias Ukio.Apartments
  alias Ukio.Bookings.Handlers.BookingService

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          params
      ) do
      is_available = BookingService.is_booking_slot_available?(apartment_id, check_in, check_out)
      IO.inspect(is_available)
      if is_available do
        IO.inspect("Available")
        with a <- Apartments.get_apartment!(apartment_id),
             b <- generate_booking_data(a, check_in, check_out) do
          Bookings.create_booking(b)
        end
      else
        IO.inspect("Not available")
        {:error, :no_booking_slot_available}
      end

  end

  defp generate_booking_data(apartment, check_in, check_out) do
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: 20_000,
      deposit: 100_000
    }
  end
end
