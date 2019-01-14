defmodule Exmail.Repo.Migrations.CleanupUserMessages do
  use Ecto.Migration

  def up do
    alter table(:user_messages) do
      remove :user_id
      remove :message_id
      add :user_id, :integer
      add :message_id, :integer
    end
  end

  def down do
    # alter table(:posts) do
    #   remove :permalinks
    #   add :permalinks, :map
    # end
  end
end
