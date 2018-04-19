defmodule SmsClient.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :to_number, :string
      add :message, :text

      timestamps()
    end

  end
end
