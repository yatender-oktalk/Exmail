defmodule Exmail.Health.Router do
  use Exmail, :router

  alias Exmail.Health.{
    Controller
  }

  get("/", Controller, :index)
end