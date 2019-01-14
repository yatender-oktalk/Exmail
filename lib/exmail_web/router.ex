defmodule Exmail.Router do
  @moduledoc """
  module to route the Link related requestes
  """
  use ExmailWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Exmail do
    pipe_through :api
    forward "/health", Health.Router
    forward "/users", User.Router
    forward "/messages", Message.Router
  end
end
