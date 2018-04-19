defmodule SmsClientWeb.TokenView do
  use SmsClientWeb, :view

  def render("token.json", %{user: user, token: token}) do
    %{
      user: %{id: user.id, name: user.name, phone: user.phone},
      token: token,
    }
  end
  def render("token.json", %{error: data}) do
    %{
      error: data
    }
  end

end
