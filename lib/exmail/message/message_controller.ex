defmodule Exmail.Message.Controller do
  @moduledoc """
  controller module for message
  """
  use Exmail, :controller

  alias Exmail.Message.{
    Model
  }

  # def index(conn, params) do

  # end

  def create(conn, params) do
    send_resp(conn, Model.create_new(conn))
  end

  def reply(conn, params) do
    send_resp(conn, Model.reply(conn))
  end

  # def forward(conn, params) do

  # end

  defp send_resp(conn, res) do
    {status, response} =
      case res do
        {:ok, resp} -> {200, %{thread_id: resp.thread_id, msg_id: resp.id}}
        {:error, resp} -> {400, resp}
      end
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(%{resp: response}))
  end
end