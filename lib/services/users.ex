defmodule AppwriteElixir.Services.Users do
  alias AppwriteElixir.Generics

  @moduledoc """
  The Users service allows you to manage your project users.
  Use this service to search, block, and view your users' info, current sessions, and latest activity logs.
  You can also use the Users service to edit your users' preferences and personal info.

  """

  @host Application.get_env(:appwrite_elixir, :host)
  @typedoc """
  $id: User ID.\n
  name:	User name.\n
  registration: User registration date in Unix timestamp.\n
  status: User status. 0 for Unactivated, 1 for active and 2 is blocked.\n
  passwordUpdate: Unix timestamp of the most recent password update\n
  email: User email address.\n
  emailVerification: Email verification status.\n
  prefs: User preferences as a key-value object\n
  """
  @type user_object :: %{
          id: String.t(),
          name: String.t(),
          registration: integer(),
          status: integer(),
          passwordUpdate: integer(),
          email: String.t(),
          emailVerification: boolean(),
          prefs: %{}
        }

  @type session_object :: %{
          id: String.t(),
          userId: String.t(),
          expire: integer(),
          provider: String.t(),
          providerUid: String.t(),
          providerToken: String.t(),
          ip: String.t(),
          osCode: String.t(),
          osName: String.t(),
          osVersion: String.t(),
          clientType: String.t(),
          clientCode: String.t(),
          clientName: String.t(),
          clientVersion: String.t(),
          clientEngine: String.t(),
          clientEngineVersion: String.t(),
          deviceName: String.t(),
          deviceBrand: String.t(),
          deviceModel: String.t(),
          countryCode: String.t(),
          countryName: String.t(),
          current: boolean()
        }

  @type session_list_object :: %{
          sum: integer(),
          sessions: List[session_object]
        }

  @type log :: %{
          event: String.t(),
          ip: String.t(),
          time: integer(),
          osCode: String.t(),
          osName: String.t(),
          osVersion: String.t(),
          clientType: String.t(),
          clientCode: String.t(),
          clientName: String.t(),
          clientVersion: String.t(),
          clientEngine: String.t(),
          clientEngineVersion: String.t(),
          deviceName: String.t(),
          deviceBrand: String.t(),
          deviceModel: String.t(),
          countryCode: String.t(),
          countryName: String.t(),
          current: boolean()
        }

  @doc """
  Get a list of all the project's users. You can use the query params to filter your results.
  """
  ## dont foege to impletment query: %{page: 2}
  @spec get_all_users() :: List[user_object]
  def get_all_users() do
    Generics.get("http://#{@host}/v1/users")
  end

  @doc """
  Get a user by its unique ID.
  """
  @spec get_one_user(id: String.t()) :: user_object
  def get_one_user(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  @doc """
  Get the user preferences by its unique ID.
  """
  @spec get_user_prefs(id: String.t()) :: %{}
  def get_user_prefs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  @doc """
  Get the user sessions list by its unique ID.
  """
  @spec get_user_sessions(id: String.t()) :: session_list_object
  def get_user_sessions(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  @doc """
  Get a user activity logs list by its unique ID.
  """
  @spec get_user_logs(id: String.t()) :: List[log]
  def get_user_logs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/logs")
  end
end
