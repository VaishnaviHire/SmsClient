defmodule SmsClientWeb.ReceivedMessageController do
  use SmsClientWeb, :controller

  alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage

  action_fallback SmsClientWeb.FallbackController

  def index(conn, _params) do
    receivedmessage = ReceivedMessages.list_receivedmessage()
    render(conn, "index.json", receivedmessage: receivedmessage)
  end

  def create(conn, %{"received_message" => received_message_params}) do
    with {:ok, %ReceivedMessage{} = received_message} <- ReceivedMessages.create_received_message(received_message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", received_message_path(conn, :show, received_message))
      |> render("show.json", received_message: received_message)
    end
  end

  def show(conn, %{"id" => id}) do
    received_message = ReceivedMessages.get_received_message!(id)
    render(conn, "show.json", received_message: received_message)
  end

  def update(conn, %{"id" => id, "received_message" => received_message_params}) do
    received_message = ReceivedMessages.get_received_message!(id)

    with {:ok, %ReceivedMessage{} = received_message} <- ReceivedMessages.update_received_message(received_message, received_message_params) do
      render(conn, "show.json", received_message: received_message)
    end
  end

  def delete(conn, %{"id" => id}) do
    received_message = ReceivedMessages.get_received_message!(id)
    with {:ok, %ReceivedMessage{}} <- ReceivedMessages.delete_received_message(received_message) do
      send_resp(conn, :no_content, "")
    end
  end
end
