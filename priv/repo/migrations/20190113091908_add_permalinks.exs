defmodule Exmail.Repo.Migrations.AddPermalinks do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :permalinks, {:array, :string}
    end
  end
end
