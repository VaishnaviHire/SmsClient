defmodule SmsClient.PhonesTest do
  use SmsClient.DataCase

  alias SmsClient.Phones

  describe "phones" do
    alias SmsClient.Phones.Phone

    @valid_attrs %{phone_number: "some phone_number"}
    @update_attrs %{phone_number: "some updated phone_number"}
    @invalid_attrs %{phone_number: nil}

    def phone_fixture(attrs \\ %{}) do
      {:ok, phone} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Phones.create_phone()

      phone
    end

    test "list_phones/0 returns all phones" do
      phone = phone_fixture()
      assert Phones.list_phones() == [phone]
    end

    test "get_phone!/1 returns the phone with given id" do
      phone = phone_fixture()
      assert Phones.get_phone!(phone.id) == phone
    end

    test "create_phone/1 with valid data creates a phone" do
      assert {:ok, %Phone{} = phone} = Phones.create_phone(@valid_attrs)
      assert phone.phone_number == "some phone_number"
    end

    test "create_phone/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Phones.create_phone(@invalid_attrs)
    end

    test "update_phone/2 with valid data updates the phone" do
      phone = phone_fixture()
      assert {:ok, phone} = Phones.update_phone(phone, @update_attrs)
      assert %Phone{} = phone
      assert phone.phone_number == "some updated phone_number"
    end

    test "update_phone/2 with invalid data returns error changeset" do
      phone = phone_fixture()
      assert {:error, %Ecto.Changeset{}} = Phones.update_phone(phone, @invalid_attrs)
      assert phone == Phones.get_phone!(phone.id)
    end

    test "delete_phone/1 deletes the phone" do
      phone = phone_fixture()
      assert {:ok, %Phone{}} = Phones.delete_phone(phone)
      assert_raise Ecto.NoResultsError, fn -> Phones.get_phone!(phone.id) end
    end

    test "change_phone/1 returns a phone changeset" do
      phone = phone_fixture()
      assert %Ecto.Changeset{} = Phones.change_phone(phone)
    end
  end
end
