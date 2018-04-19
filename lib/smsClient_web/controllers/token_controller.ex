defmodule SmsClientWeb.TokenController do
  use SmsClientWeb, :controller

  alias SmsClient.Users
  alias SmsClient.Users.User

  action_fallback SmsClientWeb.FallbackController

  def create(conn, %{"name" => name, "pass" => pass}) do

    case Users.get_and_auth_user(name, pass) do
     {:ok, %User{} = user} ->
	IO.puts(inspect(user))
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      #data = %{user: user, token: token}
      conn
      |> put_status(:created)
      #|> render("token.json", data: data)
      |> render("token.json", user: user, token: token)
      {:error, other} ->
	IO.puts(other)
	conn
	|> put_status(:created)
	|> render("token.json", error: other)
    end
  end
end
