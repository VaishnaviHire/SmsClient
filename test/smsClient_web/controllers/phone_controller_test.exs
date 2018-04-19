defmodule SmsClientWeb.PhoneControllerTest do
  use SmsClientWeb.ConnCase

  alias SmsClient.Phones
  alias SmsClient.Phones.Phone

  @create_attrs %{phone_number: "some phone_number"}
  @update_attrs %{phone_number: "some updated phone_number"}
  @invalid_attrs %{phone_number: nil}

  def fixture(:phone) do
    {:ok, phone} = Phones.create_phone(@create_attrs)
    phone
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all phones", %{conn: conn} do
      conn = get conn, phone_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create phone" do
    test "renders phone when data is valid", %{conn: conn} do
      conn = post conn, phone_path(conn, :create), phone: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, phone_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "phone_number" => "some phone_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, phone_path(conn, :create), phone: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update phone" do
    setup [:create_phone]

    test "renders phone when data is valid", %{conn: conn, phone: %Phone{id: id} = phone} do
      conn = put conn, phone_path(conn, :update, phone), phone: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, phone_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "phone_number" => "some updated phone_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, phone: phone} do
      conn = put conn, phone_path(conn, :update, phone), phone: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete phone" do
    setup [:create_phone]

    test "deletes chosen phone", %{conn: conn, phone: phone} do
      conn = delete conn, phone_path(conn, :delete, phone)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, phone_path(conn, :show, phone)
      end
    end
  end

  defp create_phone(_) do
    phone = fixture(:phone)
    {:ok, phone: phone}
  end
end
