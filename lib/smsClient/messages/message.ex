defmodule SmsClient.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :message, :string
    field :to_number, :string
    belongs_to :user, SmsClient.Users.User    

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:to_number, :message, :user_id])
    |> validate_required([:to_number, :message])
  end
end
