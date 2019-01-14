defmodule Exmail.Repo.Migrations.ChangePermalinks do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :permalinks
      add :permalinks, :map
    end
  end
end
