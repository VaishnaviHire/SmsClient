defmodule SmsClientWeb.ReceivedMessageControllerTest do
  use SmsClientWeb.ConnCase

  alias SmsClient.ReceivedMessages
  alias SmsClient.ReceivedMessages.ReceivedMessage

  @create_attrs %{body: "some body", from: "some from", to: "some to"}
  @update_attrs %{body: "some updated body", from: "some updated from", to: "some updated to"}
  @invalid_attrs %{body: nil, from: nil, to: nil}

  def fixture(:received_message) do
    {:ok, received_message} = ReceivedMessages.create_received_message(@create_attrs)
    received_message
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all receivedmessage", %{conn: conn} do
      conn = get conn, received_message_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create received_message" do
    test "renders received_message when data is valid", %{conn: conn} do
      conn = post conn, received_message_path(conn, :create), received_message: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, received_message_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "from" => "some from",
        "to" => "some to"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, received_message_path(conn, :create), received_message: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update received_message" do
    setup [:create_received_message]

    test "renders received_message when data is valid", %{conn: conn, received_message: %ReceivedMessage{id: id} = received_message} do
      conn = put conn, received_message_path(conn, :update, received_message), received_message: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, received_message_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "from" => "some updated from",
        "to" => "some updated to"}
    end

    test "renders errors when data is invalid", %{conn: conn, received_message: received_message} do
      conn = put conn, received_message_path(conn, :update, received_message), received_message: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete received_message" do
    setup [:create_received_message]

    test "deletes chosen received_message", %{conn: conn, received_message: received_message} do
      conn = delete conn, received_message_path(conn, :delete, received_message)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, received_message_path(conn, :show, received_message)
      end
    end
  end

  defp create_received_message(_) do
    received_message = fixture(:received_message)
    {:ok, received_message: received_message}
  end
end
