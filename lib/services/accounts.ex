defmodule AppwriteElixir.Services.Accounts do
  # alias AppwriteElixir.Generics
  alias Jason

  @moduledoc """
  The Account service allows you to authenticate and manage a user account.
  You can use the account service to update user information,
  retrieve the user sessions across different devices,
  and fetch the user security logs with his or her recent activity.
  You can authenticate the user account by using multiple sign-in methods available.
  Once the user is authenticated, a new session object will be created to allow the user to access his or her private data and settings.
  """

  # @host Application.get_env(:appwrite_elixir, :host)

  def createOAuth2Session() do
    
  end
end
