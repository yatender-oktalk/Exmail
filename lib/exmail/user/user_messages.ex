defmodule Exmail.UserMessages.Model do
  use Exmail, :model

  schema "user_messages" do
    field(:user_id, :integer)
    field(:message_id, :integer)
    field(:thread_id, :string, required: true)
    field(:status, :integer, default: 1)
    field(:type, :string, default: "")
    field(:is_read, :boolean, default: false)
    field(:current_folder, :string, default: "inbox")

    timestamps()
  end

  def insert_user_msg(msg_body) do
    Ecto.Changeset.change(%Exmail.UserMessages.Model{}, msg_body)
    |> Repo.insert!()
  end

  def mark_read(%{user_id: user_id, thread_id: thread_id}) do
    query =
      from(u in Exmail.UserMessages.Model,
        where: u.user_id == ^user_id and u.thread_id == ^thread_id and u.status == ^1
      )

    Exmail.Repo.update_all(query,
      set: [is_read: true]
    )

    {:ok, "success"}
  end

  def move_thread(%{user_id: user_id, thread_id: thread_id, folder: folder}) do
    query =
      from(u in Exmail.UserMessages.Model,
        where: u.user_id == ^user_id and u.thread_id == ^thread_id
      )

    Exmail.Repo.update_all(query,
      set: [current_folder: folder]
    )

    {:ok, "success"}
  end

  def delete_thread(%{user_id: user_id, thread_id: thread_id}) do
    query =
      from(u in Exmail.UserMessages.Model,
        where: u.user_id == ^user_id and u.thread_id == ^thread_id
      )

    Exmail.Repo.update_all(query,
      set: [status: 1, current_folder: "trash"]
    )

    {:ok, "success"}
  end
end
