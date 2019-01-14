defmodule Exmail.Repo.Migrations.MsgFolder do
  use Ecto.Migration

  def up do
    alter table(:user_messages) do
      add :current_folder, :string, default: "inbox"
    end
  end

  def down do
    alter table(:user_messages) do
      remove :current_folder
    end
  end
end
