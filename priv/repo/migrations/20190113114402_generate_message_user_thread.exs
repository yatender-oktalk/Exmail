defmodule Exmail.Repo.Migrations.GenerateMessageUserThread do
  use Ecto.Migration

  def up do
    create table(:messages) do
      add :body, :text, default: ""
      add :body_preview, :text, default: ""

      add :subject, :string, default: ""
      add :sender, :string, null: false
      add :type, :string, null: false

      add :parent_id, :integer
      add :status, :integer, default: 1

      add :attachments, :map
      add :receiver, :map
      add :cc, :map
      add :bcc, :map

      add :thread_id, :string, null: false

      timestamps()
    end
    create index(:messages, [:parent_id])

    create table(:users) do
      add :email, :string, null: false
      add :name, :string
      add :status, :integer, default: 1

      timestamps()
    end
    create unique_index(:users, [:email])

    create table(:user_messages) do
      add :user_id, references(:users)
      add :message_id, references(:messages)
      add :thread_id, :string, null: false
      add :status, :integer
      add :type, :string

      timestamps()
    end
    create index(:user_messages, [:user_id, :status, :thread_id])
  end

  def down do
    drop table(:messages)
    drop table(:threads)
    drop table(:users)
    drop table(:user_messages)
  end
end
