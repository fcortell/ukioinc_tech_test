defmodule Ukio.Apartments.Apartment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ukio.Markets.Market

  schema "apartments" do
    belongs_to(:market, Market)

    field :address, :string
    field :monthly_price, :integer
    field :name, :string
    field :square_meters, :integer
    field :zip_code, :string
    timestamps()
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:name, :address, :zip_code, :monthly_price, :square_meters, :market_id])
    |> validate_required([:name, :address, :zip_code, :monthly_price, :square_meters, :market_id])
  end
end
