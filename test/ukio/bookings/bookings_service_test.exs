defmodule Ukio.BookingsServiceTest do
  use Ukio.DataCase

  describe "bookings service" do
    alias Ukio.Bookings.Handlers.BookingService
    import Ukio.BookingsFixtures
    import Ukio.ApartmentsFixtures

    setup do
      %{apartment: apartment_fixture()}
      %{booking: booking_fixture()}

    end

    test "is_booking_slot_available returns false", %{booking: booking} do
      is_available = BookingService.is_booking_slot_available?(booking.apartment_id, booking.check_in, booking.check_out)
      assert is_available == false
    end
  end
end
