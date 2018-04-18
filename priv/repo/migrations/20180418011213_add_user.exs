defmodule SmsClient.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
	alter table("messages") do
		add :user_id, references(:users, on_delete: :nothing)
	end
	create index(:messages, [:user_id])
  end
end
