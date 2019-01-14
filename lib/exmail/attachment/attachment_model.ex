defmodule Exmail.Attachment.Model do
  @moduledoc """
  Model for Attachments
  """
  use Exmail, :model

  embedded_schema do
    field(:content_type, :string, default: "")
    field(:url, :string, default: "")
    field(:name, :string, default: "")
    field(:size, :float, default: 0.0)

    timestamps()
  end
end
