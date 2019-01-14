defmodule Exmail.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, default: ""
      add :body, :text, default: ""
      timestamps()
    end

    create table(:comments) do
      add :post_id, references(:posts)
      add :body, :text
      timestamps()
    end
  end
end
