defmodule SmsClientWeb.PageController do
  use SmsClientWeb, :controller
  
	alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage

  def index(conn, _params) do
    render conn, "index.html"
  end

 
end
