defmodule Exmail do
  @moduledoc """
  Exmail keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def controller do
    quote do
      use Phoenix.Controller
      import Plug.Conn
      # import UrlnerWeb.Router.Helpers
      alias ExmailWeb.Router.Helpers, as: Routes
      import ExmailWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      alias Exmail.Repo, as: Repo
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
