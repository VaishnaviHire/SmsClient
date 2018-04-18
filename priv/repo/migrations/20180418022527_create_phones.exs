defmodule SmsClient.Repo.Migrations.CreatePhones do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :phone_number, :string

      timestamps()
    end

  end
end
