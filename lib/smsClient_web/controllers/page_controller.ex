defmodule SmsClientWeb.PageController do
  use SmsClientWeb, :controller
  
	alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage

  def index(conn, _params) do
    render conn, "index.html"
  end

 def message_receive(conn, _params) do
    IO.inspect(_params)
    IO.inspect(Map.get(_params,"Body"))
    rc_params = %{from: Map.get(_params,"From"), to: Map.get(_params, "To"), body: Map.get(_params, "Body")}
    with {:ok, %ReceivedMessage{} = received_message} <- ReceivedMessages.create_received_message(rc_params) do
	IO.puts("Message received")
    end
   # IO.inspect(to)
   # IO.inspect(from)
   render conn, "message_receive.html"

response =  """  
<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Hello World!</Message>
</Response>
"""

conn
|> put_resp_header("Content-Type", "text/xml")
|> resp(:ok, response)
end



 def send_message(from, to, body) do
     message_url()
    |> HTTPoison.post!(message(from, to, body), headers())
    |> process_response()
  end



  #All private functions containing sid and auth_token

  defp process_response(%HTTPoison.Response{body: body}) do
    Poison.decode!(body, keys: :atom)
  end

 defp message(from, to, body) do
    {:form, [To: to, From: from, Body: body]}
  end

  def message_url do
    "https://api.twilio.com/2010-04-01/Accounts/AC60fbe196df066115a872f4b2c831c300/Messages.json"
  end

  # function to encode tokens
  defp headers do
    sid = "AC60fbe196df066115a872f4b2c831c300"
    auth_token = "c8810eaaf424b90ac63cb52dd14c3c49"

    encoded_token = Base.encode64("#{sid}:#{auth_token}")

    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization", "Basic " <> encoded_token}
    ]
 end

end
