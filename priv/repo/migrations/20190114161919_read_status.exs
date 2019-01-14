defmodule Exmail.Repo.Migrations.ReadStatus do
  use Ecto.Migration

  def up do
    alter table(:user_messages) do
      add :is_read, :boolean, default: false
    end
  end

  def down do
    alter table(:user_messages) do
      remove :is_read
    end
  end
end
