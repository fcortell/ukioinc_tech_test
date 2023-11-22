defmodule Ukio.MarketsTest do
  use Ukio.DataCase

  alias Ukio.Markets

  describe "markets" do
    alias Ukio.Markets.Market

    import Ukio.MarketsFixtures

    @invalid_attrs %{discount: nil, fee: nil, market: nil, vat: nil}

    test "list_markets/0 returns all markets" do
      market = market_fixture()
      assert Markets.list_markets() == [market]
    end

    test "get_market!/1 returns the market with given id" do
      market = market_fixture()
      assert Markets.get_market!(market.id) == market
    end

    test "create_market/1 with valid data creates a market" do
      valid_attrs = %{discount: 42, fee: 42, market: "some market", vat: 42}

      assert {:ok, %Market{} = market} = Markets.create_market(valid_attrs)
      assert market.discount == 42
      assert market.fee == 42
      assert market.market == "some market"
      assert market.vat == 42
    end

    test "create_market/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Markets.create_market(@invalid_attrs)
    end

    test "update_market/2 with valid data updates the market" do
      market = market_fixture()
      update_attrs = %{discount: 43, fee: 43, market: "some updated market", vat: 43}

      assert {:ok, %Market{} = market} = Markets.update_market(market, update_attrs)
      assert market.discount == 43
      assert market.fee == 43
      assert market.market == "some updated market"
      assert market.vat == 43
    end

    test "update_market/2 with invalid data returns error changeset" do
      market = market_fixture()
      assert {:error, %Ecto.Changeset{}} = Markets.update_market(market, @invalid_attrs)
      assert market == Markets.get_market!(market.id)
    end

    test "delete_market/1 deletes the market" do
      market = market_fixture()
      assert {:ok, %Market{}} = Markets.delete_market(market)
      assert_raise Ecto.NoResultsError, fn -> Markets.get_market!(market.id) end
    end

    test "change_market/1 returns a market changeset" do
      market = market_fixture()
      assert %Ecto.Changeset{} = Markets.change_market(market)
    end
  end
end
