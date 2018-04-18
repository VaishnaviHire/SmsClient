defmodule SmsClient.Phones.Phone do
  use Ecto.Schema
  import Ecto.Changeset


  schema "phones" do
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(phone, attrs) do
    phone
    |> cast(attrs, [:phone_number])
    |> validate_required([:phone_number])
  end
end
