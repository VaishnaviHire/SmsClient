defmodule SmsClient.Repo.Migrations.CreateReceivedmessage do
  use Ecto.Migration

  def change do
    create table(:receivedmessage) do
      add :from, :string
      add :to, :string
      add :body, :string

      timestamps()
    end

  end
end
