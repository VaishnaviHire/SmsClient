defmodule SmsClient.ReceivedMessagesTest do
  use SmsClient.DataCase

  alias SmsClient.ReceivedMessages

  describe "receivedmessage" do
    alias SmsClient.ReceivedMessages.ReceivedMessage

    @valid_attrs %{body: "some body", from: "some from", to: "some to"}
    @update_attrs %{body: "some updated body", from: "some updated from", to: "some updated to"}
    @invalid_attrs %{body: nil, from: nil, to: nil}

    def received_message_fixture(attrs \\ %{}) do
      {:ok, received_message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ReceivedMessages.create_received_message()

      received_message
    end

    test "list_receivedmessage/0 returns all receivedmessage" do
      received_message = received_message_fixture()
      assert ReceivedMessages.list_receivedmessage() == [received_message]
    end

    test "get_received_message!/1 returns the received_message with given id" do
      received_message = received_message_fixture()
      assert ReceivedMessages.get_received_message!(received_message.id) == received_message
    end

    test "create_received_message/1 with valid data creates a received_message" do
      assert {:ok, %ReceivedMessage{} = received_message} = ReceivedMessages.create_received_message(@valid_attrs)
      assert received_message.body == "some body"
      assert received_message.from == "some from"
      assert received_message.to == "some to"
    end

    test "create_received_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ReceivedMessages.create_received_message(@invalid_attrs)
    end

    test "update_received_message/2 with valid data updates the received_message" do
      received_message = received_message_fixture()
      assert {:ok, received_message} = ReceivedMessages.update_received_message(received_message, @update_attrs)
      assert %ReceivedMessage{} = received_message
      assert received_message.body == "some updated body"
      assert received_message.from == "some updated from"
      assert received_message.to == "some updated to"
    end

    test "update_received_message/2 with invalid data returns error changeset" do
      received_message = received_message_fixture()
      assert {:error, %Ecto.Changeset{}} = ReceivedMessages.update_received_message(received_message, @invalid_attrs)
      assert received_message == ReceivedMessages.get_received_message!(received_message.id)
    end

    test "delete_received_message/1 deletes the received_message" do
      received_message = received_message_fixture()
      assert {:ok, %ReceivedMessage{}} = ReceivedMessages.delete_received_message(received_message)
      assert_raise Ecto.NoResultsError, fn -> ReceivedMessages.get_received_message!(received_message.id) end
    end

    test "change_received_message/1 returns a received_message changeset" do
      received_message = received_message_fixture()
      assert %Ecto.Changeset{} = ReceivedMessages.change_received_message(received_message)
    end
  end
end
