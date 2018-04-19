defmodule SmsClientWeb.MessageController do
  use SmsClientWeb, :controller

  alias SmsClient.Messages
  alias SmsClient.Messages.Message
  alias SmsClient.Repo

  action_fallback SmsClientWeb.FallbackController

  def index(conn, _params) do
    messages = Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Messages.create_message(message_params) do
      # SmsClientWeb.PageController.send_message('+17817677045', message_params.to_number, message_params.message)
      message = Repo.preload(message, :user)
      conn
      |> put_status(:created)
      |> put_resp_header("location", message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messages.get_message!(id)

    with {:ok, %Message{} = message} <- Messages.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    with {:ok, %Message{}} <- Messages.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
