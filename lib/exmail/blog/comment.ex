defmodule Exmail.Blog.Comment do
  use Exmail, :model


  schema "comments" do
    field(:body, :string, default: "")
    belongs_to :post, Exmail.Blog.Post
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
  end
end
