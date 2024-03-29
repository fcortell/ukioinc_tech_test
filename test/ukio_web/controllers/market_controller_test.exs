defmodule UkioWeb.MarketControllerTest do
  use UkioWeb.ConnCase

  import Ukio.MarketsFixtures

  alias Ukio.Markets.Market

  @create_attrs %{
    discount: 42,
    fee: 42,
    market: "some market",
    vat: 42
  }
  @update_attrs %{
    discount: 43,
    fee: 43,
    market: "some updated market",
    vat: 43
  }
  @invalid_attrs %{discount: nil, fee: nil, market: nil, vat: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all markets", %{conn: conn} do
      conn = get(conn, ~p"/api/markets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create market" do
    test "renders market when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/markets", market: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/markets/#{id}")

      assert %{
               "id" => ^id,
               "discount" => 42,
               "fee" => 42,
               "market" => "some market",
               "vat" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/markets", market: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update market" do
    setup [:create_market]

    test "renders market when data is valid", %{conn: conn, market: %Market{id: id} = market} do
      conn = put(conn, ~p"/api/markets/#{market}", market: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/markets/#{id}")

      assert %{
               "id" => ^id,
               "discount" => 43,
               "fee" => 43,
               "market" => "some updated market",
               "vat" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, market: market} do
      conn = put(conn, ~p"/api/markets/#{market}", market: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete market" do
    setup [:create_market]

    test "deletes chosen market", %{conn: conn, market: market} do
      conn = delete(conn, ~p"/api/markets/#{market}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/markets/#{market}")
      end
    end
  end

  defp create_market(_) do
    market = market_fixture()
    %{market: market}
  end
end
