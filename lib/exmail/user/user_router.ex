defmodule Exmail.User.Router do
  use Exmail, :router

  alias Exmail.User.{
    Controller
  }

  get("/:id/threads", Controller, :index)
  get("/:id/threads/:thread_id", Controller, :get_thread)
  put("/:id/threads/:thread_id/read", Controller, :read_thread)
  put("/:id/threads/:thread_id/move", Controller, :move_thread)
  delete("/:id/threads/:thread_id", Controller, :delete_thread)
end
