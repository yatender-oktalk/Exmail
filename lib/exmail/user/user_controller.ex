defmodule Exmail.User.Controller do
  use Exmail, :controller

  alias Exmail.User.{
    Model
  }

  def index(conn, params) do
    send_resp(conn, Model.get_messages(params["id"], params["current_folder"]))
  end

  def get_thread(conn, params) do
    send_resp(conn, Model.get_thread(params["id"], params["thread_id"]))
  end

  def read_thread(conn, params) do
    send_resp(conn, Model.mark_read(params["id"], params["thread_id"]))
  end

  def move_thread(conn, params) do
    send_resp(conn, Model.move_thread(params["id"], params["thread_id"], params["folder"]))
  end

  def delete_thread(conn, params) do
    send_resp(conn, Model.delete_thread(params["id"], params["thread_id"]))
  end

  defp send_resp(conn, res) do
    {status, response} =
      case res do
        {:ok, resp} -> {200, resp}
        {:error, resp} -> {400, resp}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(%{resp: response}))
  end
end
