defmodule Exmail.User.Model do
  use Exmail, :model

  alias Exmail.User.{
    Model
  }

  @primary_key {:id, :id, autogenerate: true}
  schema "users" do
    field(:email, :string, required: true)
    field(:name, :string, required: true)
    field(:status, :integer, default: 1)
    timestamps()
  end

  # def get_messages(conn, params) do
  def get_messages(user_id, current_folder) do
    query =
      from u in Exmail.User.Model,
      where: u.id == ^user_id,
      join: um in Exmail.UserMessages.Model,
      on: um.user_id == u.id,
      join: m in Exmail.Message.Model,
      on: um.message_id == m.id,
      where: um.current_folder== ^current_folder,
      order_by: [desc: um.inserted_at ],
      select: %{
        um_id: um.id,
        thread_id: um.thread_id,
        message_id: um.message_id,
        subject: m.subject,
        user_msg_type: um.type,
        thread_msg_type: m.type,
        cc: m.cc,
        bcc: m.bcc,
        receiver: m.receiver,
        attachments: m.attachments,
        sender: m.sender,
        body: m.body,
        is_read: um.is_read,
        inserted_at: um.inserted_at
      }

      IO.inspect(query, label: "query")
    list = Repo.all(query)
    {:ok, get_formed_messages(list)}
  end

  def get_thread(user_id, thread_id) do
    query =
      from u in Exmail.User.Model,
      where: u.id == ^user_id,
      join: um in Exmail.UserMessages.Model,
      on: um.user_id == u.id,
      join: m in Exmail.Message.Model,
      on: um.message_id == m.id,
      where: um.thread_id== ^thread_id and um.status == ^1,
      order_by: [desc: um.inserted_at ],
      select: %{
        um_id: um.id,
        thread_id: um.thread_id,
        message_id: um.message_id,
        subject: m.subject,
        user_msg_type: um.type,
        thread_msg_type: m.type,
        cc: m.cc,
        bcc: m.bcc,
        receiver: m.receiver,
        attachments: m.attachments,
        sender: m.sender,
        body: m.body,
        is_read: um.is_read,
        inserted_at: um.inserted_at
      }
    list = Repo.all(query)
    {:ok, get_formed_messages(list)}
  end

  def fetch_user(email_list) do
    query =
      from u in Exmail.User.Model,
      where: u.email in ^email_list and u.status == ^1,
      select: u.id

    Repo.all(query)
  end

  def get_formed_messages([]) do
    []
  end

  def get_formed_messages(list) do
    list
    |> Enum.group_by(fn x -> x[:thread_id] end)
    |> Enum.map(fn {x, v} -> %{ thread_id: x, items: v} end)
  end

  def mark_read(user_id, thread_id) do
    Exmail.UserMessages.Model.mark_read(%{user_id: user_id, thread_id: thread_id})
  end

  def delete_thread(user_id, thread_id) do
    Exmail.UserMessages.Model.delete_thread(%{user_id: user_id, thread_id: thread_id})
  end

  def move_thread(user_id, thread_id, folder) do
    Exmail.UserMessages.Model.move_thread(%{user_id: user_id, thread_id: thread_id, folder: folder})
  end

  # def item() do
  #   name_list = [
  #     %{age: 23, name: "yatender"},
  #     %{age: 30, name: "yatender"},
  #     %{age: 22, name: "monu"},
  #     %{age: 44, name: "monu"}
  #   ]

  #   name_list
  #   |> Enum.group_by(fn x->   end)

  # end

  # [
  #   {
  #     name: "yatender",
  #     items: [
  #       %{age: 23, name: "yatender"},
  #       %{age: 30, name: "yatender"},
  #     ]
  #   },
  #   {
  #     name: "monu",
  #     items: [
  #       %{age: 22, name: "monu"},
  #       %{age: 44, name: "monu"}
  #     ]
  #   }
  # ]
end
