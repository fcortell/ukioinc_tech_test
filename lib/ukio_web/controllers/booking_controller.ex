defmodule UkioWeb.BookingController do
  use UkioWeb, :controller

  alias Ukio.Bookings
  alias Ukio.Bookings.Booking
  alias Ukio.Bookings.Handlers.BookingCreator

  action_fallback UkioWeb.FallbackController

  def create(conn, %{"booking" => booking_params}) do
    case BookingCreator.create(booking_params) do
      {:ok, %Booking{} = booking} ->
        conn
        |> put_status(:created)
        |> render(:show, booking: booking)

      {:error, :no_booking_slot_available} ->
        conn
        |> put_status(:conflict)
        |> json(%{error: "No matching slot available for provided apartment and date range"})
    end
  rescue
    _ ->
      conn
      |> put_status(:unprocessable_entity)
      |> json(%{errors: %{base: "Invalid booking request"}})
  end

  def show(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)
    render(conn, :show, booking: booking)
  end
end
