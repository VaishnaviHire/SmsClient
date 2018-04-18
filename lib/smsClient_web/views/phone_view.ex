defmodule SmsClientWeb.PhoneView do
  use SmsClientWeb, :view
  alias SmsClientWeb.PhoneView

  def render("index.json", %{phones: phones}) do
    %{data: render_many(phones, PhoneView, "phone.json")}
  end

  def render("show.json", %{phone: phone}) do
    %{data: render_one(phone, PhoneView, "phone.json")}
  end

  def render("phone.json", %{phone: phone}) do
    %{id: phone.id,
      phone_number: phone.phone_number}
  end
end
