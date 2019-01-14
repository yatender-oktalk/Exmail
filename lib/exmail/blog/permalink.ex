defmodule Exmail.Permalink.Model do
  use Exmail, :model

  embedded_schema do
    field :url
    timestamps
  end
end
