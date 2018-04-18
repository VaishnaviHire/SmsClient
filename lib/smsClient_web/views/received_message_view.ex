defmodule SmsClientWeb.ReceivedMessageView do
  use SmsClientWeb, :view
  alias SmsClientWeb.ReceivedMessageView

  def render("index.json", %{receivedmessage: receivedmessage}) do
    %{data: render_many(receivedmessage, ReceivedMessageView, "received_message.json")}
  end

  def render("show.json", %{received_message: received_message}) do
    %{data: render_one(received_message, ReceivedMessageView, "received_message.json")}
  end

  def render("received_message.json", %{received_message: received_message}) do
    %{id: received_message.id,
      from: received_message.from,
      to: received_message.to,
      body: received_message.body}
  end
end
