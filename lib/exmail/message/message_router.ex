defmodule Exmail.Message.Router do
  use Exmail, :router

  alias Exmail.Message.{
    Controller
  }

  post("/new", Controller, :create)
  post("/reply", Controller, :reply)

end
