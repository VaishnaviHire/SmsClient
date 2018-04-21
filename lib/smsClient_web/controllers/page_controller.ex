defmodule SmsClientWeb.PageController do
  use SmsClientWeb, :controller
  
	alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def sentmessages(conn, _params) do
     render conn, "sentmessages.html"
  end

 
end
