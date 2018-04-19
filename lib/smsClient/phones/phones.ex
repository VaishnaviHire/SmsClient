defmodule SmsClient.Phones do
  @moduledoc """
  The Phones context.
  """

  import Ecto.Query, warn: false
  alias SmsClient.Repo

  alias SmsClient.Phones.Phone

  @doc """
  Returns the list of phones.

  ## Examples

      iex> list_phones()
      [%Phone{}, ...]

  """
  def list_phones do
    Repo.all(Phone)
  end

  @doc """
  Gets a single phone.

  Raises `Ecto.NoResultsError` if the Phone does not exist.

  ## Examples

      iex> get_phone!(123)
      %Phone{}

      iex> get_phone!(456)
      ** (Ecto.NoResultsError)

  """
  def get_phone!(id), do: Repo.get!(Phone, id)

  @doc """
  Creates a phone.

  ## Examples

      iex> create_phone(%{field: value})
      {:ok, %Phone{}}

      iex> create_phone(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_phone(attrs \\ %{}) do
    %Phone{}
    |> Phone.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a phone.

  ## Examples

      iex> update_phone(phone, %{field: new_value})
      {:ok, %Phone{}}

      iex> update_phone(phone, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_phone(%Phone{} = phone, attrs) do
    phone
    |> Phone.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Phone.

  ## Examples

      iex> delete_phone(phone)
      {:ok, %Phone{}}

      iex> delete_phone(phone)
      {:error, %Ecto.Changeset{}}

  """
  def delete_phone(%Phone{} = phone) do
    Repo.delete(phone)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking phone changes.

  ## Examples

      iex> change_phone(phone)
      %Ecto.Changeset{source: %Phone{}}

  """
  def change_phone(%Phone{} = phone) do
    Phone.changeset(phone, %{})
  end
end
