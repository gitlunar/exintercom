defmodule ExIntercom.User do
  @moduledoc """
  Wrapper around Intercom Users endpoint
  """

  import ExIntercom.Base

  @endpoint "https://api.intercom.io/users"

  @doc """
  Returns single user by its ID
  """
  @spec find([id: <<>>]) :: %{}
  def find(id: id) do
    fetch(@endpoint <> "/" <> to_string(id))
  end

  def find_by_user_id(user_id) do
    fetch(@endpoint <> "?user_id=" <> user_id) 
  end

  def find_by_email(email) do
    fetch(@endpoint <> "?email=" <> email)
  end

  defp fetch(url) do
    url |> request |> Poison.decode!
  end
end
