defmodule Ukio.Markets.Market do
  use Ecto.Schema
  import Ecto.Changeset

  schema "markets" do
    field :discount, :integer
    field :fee, :integer
    field :market, :string
    field :vat, :integer

    timestamps()
  end

  @doc false
  def changeset(market, attrs) do
    market
    |> cast(attrs, [:market, :fee, :discount, :vat])
    |> validate_required([:market, :fee, :discount, :vat])
  end
end
