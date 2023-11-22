defmodule Ukio.Repo.Migrations.AddMarketTable do
  use Ecto.Migration

  def up do
    create table(:markets) do
      add :market,    :string, size: 40
      add :fee, :integer
      add :discount, :integer
      add :vat, :integer
      timestamps()
    end

    alter table(:apartments) do
      add :market_id, references(:markets), default: 1
    end
  end

  def down do
    alter table(:apartments) do
      remove :market
    end
    drop table(:market)
  end
end
