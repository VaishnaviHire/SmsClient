defmodule SmsClientWeb.MessageController do
  use SmsClientWeb, :controller

  alias SmsClient.Messages
  alias SmsClient.Messages.Message
  alias SmsClient.Repo
  alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage



  action_fallback SmsClientWeb.FallbackController

  def index(conn, _params) do
    messages = Messages.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
     IO.inspect(message_params)
    with {:ok, %Message{} = message} <- Messages.create_message(message_params) do
      message = Repo.preload(message, :user)
      IO.inspect(message)
      send_message('+17817677045', message.to_number, message.message)

      conn
      |> put_status(:created)
      |> put_resp_header("location", message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
     # send_message('+17817677045', message_params.to_number, message_params.message)

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


def message_receive(conn, _params) do
#    IO.inspect(_params)
#    IO.inspect(Map.get(_params,"Body"))
    rc_params = %{from: Map.get(_params,"From"), to: Map.get(_params, "To"), body: Map.get(_params, "Body")}
    with {:ok, %ReceivedMessage{} = received_message} <- ReceivedMessages.create_received_message(rc_params) do
        IO.puts("Message received")
    end
   # IO.inspect(to)
   # IO.inspect(from)
#   render conn, "message_receive.html"

# response =  """
# <?xml version="1.0" encoding="UTF-8" ?>
# <Response>
#    <Message>Hello World!</Message>
# </Response>
# """

#conn
#|> put_resp_header("Content-Type", "text/xml")
#|> resp(:ok, response)
end



 def send_message(from, to, body) do
     message_url()
    |> HTTPoison.post!(message(from, to, body), headers())
    |> process_response()
  end


def process_response(%HTTPoison.Response{body: body}) do
    Poison.decode!(body, keys: :atom)
  end

 defp message(from, to, body) do
    {:form, [To: to, From: from, Body: body]}
  end

  def message_url do
    "https://api.twilio.com/2010-04-01/Accounts/"sid"/Messages.json"
  end

  # function to encode tokens
  defp headers do
    sid = "your_sid"
    auth_token = "your_auth_token"

    encoded_token = Base.encode64("#{sid}:#{auth_token}")

    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization", "Basic " <> encoded_token}
    ]
 end

end
