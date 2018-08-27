defmodule Surgery.HPSService do
  @moduledoc """
  HPS Service
  """

  # TODO Move to config
  @server "http://10.11.13.203:8069"

  @doc """
  Returns user from remote server.
  """

  def fetch_remote_user(token) do
    headers = %{
      "Content-Type": "application/json",
      "Authorization": "Bearer #{token}"
    }
    case HTTPoison.get "#{@server}/api/user-service/users/user", headers do
      {:ok, %HTTPoison.Response{status_code: 202, body: body}} ->
        user = Poison.decode!(body)
        user
          |> Map.put("name", "#{user["firstName"]} #{user["lastName"]}")
          |> Map.put("token", token)
      # TODO Handle failure
    end
  end

end
