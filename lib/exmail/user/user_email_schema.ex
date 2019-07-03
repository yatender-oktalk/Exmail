defmodule Exmail.User.EmailUsers.Model do
  use Exmail, :model

  embedded_schema do
    field(:email)
    field(:name)
  end

  @doc false
  def changeset(attrs) when is_list(attrs) do
    attrs
    |> Enum.map(fn attr ->
      %Exmail.User.EmailUsers.Model{}
      |> cast(attr, [:email, :name])
    end)
  end

  def changeset(attrs) do
    attrs

    %Exmail.User.EmailUsers.Model{}
    |> cast(attrs, [:email, :name])
  end
end
