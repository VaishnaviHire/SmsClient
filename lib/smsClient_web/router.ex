defmodule SmsClientWeb.Router do
  use SmsClientWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SmsClientWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/message_receive", PageController, :message_receive
  end

  # Other scopes may use custom stacks.
   scope "/api/v1", SmsClientWeb do
     pipe_through :api
     resources "/messages", MessageController, except: [:new, :edit]
     resources "/users", UserController, except: [:new, :edit]
     resources "/phones", PhoneController, except: [:new, :edit]
     resources "/receivedmessage", ReceivedMessageController, except: [:new, :edit]
     post "/token", TokenController, :create
   end
end
