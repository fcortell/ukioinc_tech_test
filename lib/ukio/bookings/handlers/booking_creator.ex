defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Bookings
  alias Ukio.Apartments
  alias Ukio.Markets
  alias Ukio.Bookings.Handlers.BookingService

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          _
      ) do
      is_available = BookingService.is_booking_slot_available?(apartment_id, check_in, check_out)
      if is_available do
        with a <- Apartments.get_apartment!(apartment_id),
             b <- generate_booking_data(a, check_in, check_out) do
          Bookings.create_booking(b)
        end
      else
        {:error, :no_booking_slot_available}
      end

  end

  defp generate_booking_data(apartment, check_in, check_out) do
    market = Markets.get_market!(apartment.market_id)
    booking = %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
    }
    case market.market do
      "Mars" ->
        %{
          utilities: market.fee * apartment.square_meters,
          deposit: apartment.monthly_price,
        }
        |> Map.merge(booking)
      "Earth" ->
        %{

          utilities: 20_000,
          deposit: 100_000
        }
        |> Map.merge(booking)
      _ ->
        %{

          utilities: 20_000,
          deposit: 100_000
        }
        |> Map.merge(booking)
    end
  end
end
