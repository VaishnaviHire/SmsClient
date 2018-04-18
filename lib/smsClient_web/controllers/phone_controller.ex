defmodule SmsClientWeb.PhoneController do
  use SmsClientWeb, :controller

  alias SmsClient.Phones
  alias SmsClient.Phones.Phone

  action_fallback SmsClientWeb.FallbackController

  def index(conn, _params) do
    phones = Phones.list_phones()
    render(conn, "index.json", phones: phones)
  end

  def create(conn, %{"phone" => phone_params}) do
    with {:ok, %Phone{} = phone} <- Phones.create_phone(phone_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", phone_path(conn, :show, phone))
      |> render("show.json", phone: phone)
    end
  end

  def show(conn, %{"id" => id}) do
    phone = Phones.get_phone!(id)
    render(conn, "show.json", phone: phone)
  end

  def update(conn, %{"id" => id, "phone" => phone_params}) do
    phone = Phones.get_phone!(id)

    with {:ok, %Phone{} = phone} <- Phones.update_phone(phone, phone_params) do
      render(conn, "show.json", phone: phone)
    end
  end

  def delete(conn, %{"id" => id}) do
    phone = Phones.get_phone!(id)
    with {:ok, %Phone{}} <- Phones.delete_phone(phone) do
      send_resp(conn, :no_content, "")
    end
  end
end
