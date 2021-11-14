defmodule AppwriteElixir.Services.Accounts do
  alias AppwriteElixir.Services.Generics

  @doc """
  The Account service allows you to authenticate and manage a user account.
  You can use the account service to update user information,
  retrieve the user sessions across different devices,
  and fetch the user security logs with his or her recent activity.
  You can authenticate the user account by using multiple sign-in methods available.
  Once the user is authenticated, a new session object will be created to allow the user to access his or her private data and settings.
  """

  @host Application.get_env(:appwrite_elixir, :host)

  def get_all_users() do
    Generics.get("http://#{@host}/v1/users")
  end

  def get_one_user(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  def get_user_sessions(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  def get_user_logs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/logs")
  end

  def create_user() do
    Generics.post("http://#{@host}/v1/account", %{
      "email" => 'email@example.com',
      "password" => 'password'
    })
  end
end
