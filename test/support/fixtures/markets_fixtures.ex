defmodule Ukio.MarketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ukio.Markets` context.
  """

  @doc """
  Generate a market.
  """
  def market_fixture(attrs \\ %{}) do
    {:ok, market} =
      attrs
      |> Enum.into(%{
        discount: 42,
        fee: 42,
        market: "some market",
        vat: 42
      })
      |> Ukio.Markets.create_market()

    market
  end
end
