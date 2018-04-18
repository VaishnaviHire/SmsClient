defmodule SmsClient.ReceivedMessages.ReceivedMessage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "receivedmessage" do
    field :body, :string
    field :from, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(received_message, attrs) do
    received_message
    |> cast(attrs, [:from, :to, :body])
    |> validate_required([:from, :to, :body])
  end
end
