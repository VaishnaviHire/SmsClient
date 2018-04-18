defmodule SmsClient.ReceivedMessages do
  @moduledoc """
  The ReceivedMessages context.
  """

  import Ecto.Query, warn: false
  alias SmsClient.Repo

  alias SmsClient.ReceivedMessages.ReceivedMessage

  @doc """
  Returns the list of receivedmessage.

  ## Examples

      iex> list_receivedmessage()
      [%ReceivedMessage{}, ...]

  """
  def list_receivedmessage do
    Repo.all(ReceivedMessage)
  end

  @doc """
  Gets a single received_message.

  Raises `Ecto.NoResultsError` if the Received message does not exist.

  ## Examples

      iex> get_received_message!(123)
      %ReceivedMessage{}

      iex> get_received_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_received_message!(id), do: Repo.get!(ReceivedMessage, id)

  @doc """
  Creates a received_message.

  ## Examples

      iex> create_received_message(%{field: value})
      {:ok, %ReceivedMessage{}}

      iex> create_received_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_received_message(attrs \\ %{}) do
    %ReceivedMessage{}
    |> ReceivedMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a received_message.

  ## Examples

      iex> update_received_message(received_message, %{field: new_value})
      {:ok, %ReceivedMessage{}}

      iex> update_received_message(received_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_received_message(%ReceivedMessage{} = received_message, attrs) do
    received_message
    |> ReceivedMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ReceivedMessage.

  ## Examples

      iex> delete_received_message(received_message)
      {:ok, %ReceivedMessage{}}

      iex> delete_received_message(received_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_received_message(%ReceivedMessage{} = received_message) do
    Repo.delete(received_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking received_message changes.

  ## Examples

      iex> change_received_message(received_message)
      %Ecto.Changeset{source: %ReceivedMessage{}}

  """
  def change_received_message(%ReceivedMessage{} = received_message) do
    ReceivedMessage.changeset(received_message, %{})
  end
end
