defmodule Exmail.Message.Model do
  @moduledoc """
  Model for Message
  """

  use Exmail, :model

  alias Exmail.Message.{
    Model
  }

  alias Exmail.UserMessages.Model, as: UserMsgModel

  @primary_key {:id, :id, autogenerate: true}
  schema "messages" do
    field(:body, :string, default: "")
    field(:body_preview, :string, default: "")
    field(:subject, :string, default: "")
    field(:sender, :string, required: true)

    field(:parent_id, :integer)
    field(:type, :string, default: "new")
    field(:status, :integer, default: 1)
    field(:thread_id, :string, required: true)

    embeds_many(:attachments, Exmail.Attachment.Model)
    embeds_many(:receiver, Exmail.User.EmailUsers.Model)
    embeds_many(:cc, Exmail.User.EmailUsers.Model)
    embeds_many(:bcc, Exmail.User.EmailUsers.Model)

    timestamps()
  end

  def create_new(conn) do
    handle_create(conn.body_params)
  end

  def reply(conn) do
    handle_reply(conn.body_params)
  end

  def handle_create(msg_body) do
    msg =
      case msg_body == nil do
        true ->
          %{
            "body" => "hello this is body",
            "subject" => "this is testing subject",
            "sender" => "yatender@getvokal.com",
            "subject" => "this is testing subject",
            "attachments" => [],
            "cc" => [%{"email" => "yatender@outlook.com", "name" => "yatender"}],
            "bcc" => [%{"email" => "jeet@gmail.com", "name" => "jeet"}],
            "receiver" => [%{"email" => "yatender@gmail.com"}]
          }

        _ ->
          msg_body
      end

    attachment_keyword = user_struct(msg["attachments"])
    cc_keyword = user_struct(msg["cc"])
    bcc_keyword = user_struct(msg["bcc"])
    receiver_keyword = user_struct(msg["receiver"])

    msg_keyword =
      Keyword.new()
      |> Keyword.put(:body, msg["body"])
      |> Keyword.put(:body_preview, String.slice(msg["body"], 0, 20))
      |> Keyword.put(:sender, msg["sender"])
      |> Keyword.put(:subject, msg["subject"])
      |> Keyword.put(:thread_id, Ecto.UUID.generate())
      |> Keyword.put(:attachments, attachment_keyword)
      |> Keyword.put(:cc, cc_keyword)
      |> Keyword.put(:bcc, bcc_keyword)
      |> Keyword.put(:receiver, receiver_keyword)

    message_changeset = Ecto.Changeset.change(%Exmail.Message.Model{}, msg_keyword)
    insert_response = Repo.insert(message_changeset)

    case insert_response do
      {:ok, resp} ->
        spawn(fn -> handle_user_msg(msg, resp) end)

      {:error, _} ->
        ""
    end

    insert_response
  end

  def handle_reply(msg_body) do
    msg =
      case msg_body == nil do
        true ->
          %{
            "body" => "hello this is body reply",
            "subject" => "this is testing subject",
            "sender" => "yatender@gmail.com",
            "attachments" => [],
            "parent_id" => 25,
            "type" => "reply",
            "thread_id" => "6ba787de-23cc-4d50-87cb-651c2b36c9f1",
            "cc" => [%{"email" => "yatender@outlook.com", "name" => "yatender"}],
            "bcc" => [%{"email" => "jeet@gmail.com", "name" => "yatender"}],
            "receiver" => [%{"email" => "yatender@getvokal.com"}]
          }

        _ ->
          msg_body
      end

    attachment_keyword = user_struct(msg["attachments"])
    cc_keyword = user_struct(msg["cc"])
    bcc_keyword = user_struct(msg["bcc"])
    receiver_keyword = user_struct(msg["receiver"])

    msg_keyword =
      Keyword.new()
      |> Keyword.put(:body, msg["body"])
      |> Keyword.put(:body_preview, String.slice(msg["body"], 0, 20))
      |> Keyword.put(:sender, msg["sender"])
      |> Keyword.put(:subject, msg["subject"])
      |> Keyword.put(:thread_id, msg["thread_id"])
      |> Keyword.put(:type, msg["type"])
      |> Keyword.put(:parent_id, msg["parent_id"])
      |> Keyword.put(:attachments, attachment_keyword)
      |> Keyword.put(:cc, cc_keyword)
      |> Keyword.put(:bcc, bcc_keyword)
      |> Keyword.put(:receiver, receiver_keyword)

    message_changeset = Ecto.Changeset.change(%Exmail.Message.Model{}, msg_keyword)
    insert_response = Repo.insert(message_changeset)

    case insert_response do
      {:ok, resp} ->
        spawn(fn -> handle_user_msg(msg, resp) end)

      {:error, _} ->
        ""
    end

    insert_response
  end

  def handle_user_msg(msg_body, resp) do
    parse_msg_resp(msg_body, resp)
  end

  defp parse_msg_resp(msg_body, resp) do
    cc = change_params(msg_body["cc"], resp, "received")
    bcc = change_params(msg_body["bcc"], resp, "received")
    receiver = change_params(msg_body["receiver"], resp, "received")
    sender = change_params(msg_body["sender"], resp, "sent")
  end

  def change_params(msg_body, resp, type) do
    msg_body
    |> fetch_email
    |> fetch_user_id
    |> Enum.map(fn x ->
      [type: type, user_id: x]
    end)
    |> Enum.map(fn x -> x ++ [message_id: resp.id, thread_id: resp.thread_id] end)
    |> Enum.map(fn x ->
      UserMsgModel.insert_user_msg(x)
    end)
  end

  def fetch_email([]) do
    []
  end

  def fetch_email(user_list) when is_list(user_list) do
    Enum.map(user_list, & &1["email"])
  end

  def fetch_email(%{"email" => user}) do
    [user]
  end

  def fetch_email(user) do
    [user]
  end

  def fetch_user_id([]) do
    []
  end

  def fetch_user_id(user_email_list) do
    IO.inspect(user_email_list)
    Exmail.User.Model.fetch_user(user_email_list)
  end

  def user_struct(msg) do
    case msg in [nil, []] do
      true ->
        # %Exmail.User.EmailUsers.Model{}
        []

      _ ->
        Enum.map(msg, fn user_data ->
          user = %Exmail.User.EmailUsers.Model{}
          %Exmail.User.EmailUsers.Model{user | name: user_data["name"], email: user_data["email"]}
        end)
    end
  end
end
