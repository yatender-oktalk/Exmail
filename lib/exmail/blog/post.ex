defmodule Exmail.Blog.Post do
  use Exmail, :model


  schema "posts" do
    field(:title, :string, default: "")
    field(:body, :string, default: "")
    has_many(:comments, Exmail.Blog.Comment)
    embeds_many(:permalinks, Exmail.Permalink.Model)
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end

# defmodule Exmail.Permalink.Model do
#   use Exmail, :model

#   embedded_schema do
#     field :url
#     timestamps
#   end
# end



# Repo.insert!(%Exmail.Blog.Post {
#   title: "Hello",
#   body: "world",
#   comments: [
#     %Comment{body: "Excellent!"}
#   ]
# })


# inserting
# Ecto.Changeset.change(%Exmail.Blog.Post{}, [title: "this is the best"])

#updating
# Exmail.Repo.get_by(Exmail.Blog.Post, %{id: 1})
# |> Ecto.Changeset.change(%{body: "this is the updated body"})
# |> Repo.update()

#build comment
# %Comment{post_id: post.id, body: "Excellent!"}


#embeding
# Exmail.Repo.insert!(%Exmail.Post.Model{
#   title: "Hello",
#   permalinks: [
#     %Permalink{url: "example.com/thebest"},
#     %Permalink{url: "another.com/mostaccessed"}
#   ]
# })

# Exmail.Repo.insert!(%Exmail.Blog.Post {
#   title: "Hello",
#   permalinks: [
#     %Exmail.Permalink.Model{url: "example.com/thebest"},
#     %Exmail.Permalink.Model{url: "another.com/mostaccessed"}
#   ]
# })
