defmodule SmsClientWeb.MessageView do
  use SmsClientWeb, :view
  alias SmsClientWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      to_number: message.to_number,
      message: message.message, user_id: message.user.id}
  end
end
