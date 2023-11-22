defmodule Ukio.ApartmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ukio.Apartments` context.
  """
  alias Ukio.MarketsFixtures

  @doc """
  Generate a apartment.
  """
  def apartment_fixture(attrs \\ %{}) do
    market = MarketsFixtures.market_fixture()

    {:ok, apartment} =
      attrs
      |> Enum.into(%{
        address: "some address",
        monthly_price: 250_000,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code",
        market_id: market.id
      })
      |> Ukio.Apartments.create_apartment()

    apartment
  end
end
