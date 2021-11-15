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

  @typedoc """

  $id: Session ID.

  userId: User ID.

  expire: Session expiration date in Unix timestamp.

  provider: Session Provider.

  providerUid: Session Provider User ID.

  providerToken: Session Provider Token.

  ip: IP session in use when the session was created.

  osCode: Operating system code name. View list of available options.

  osName: Operating system name.

  osVersion: Operating system version.

  clientType: Client type.

  clientCode: Client code name.

  clientName: Client name.

  clientVersion: Client version.

  clientEngine: Client engine name.

  clientEngineVersion: Client engine name.

  deviceName: Device name.

  deviceBrand: Device brand name.

  deviceModel: Device model name.

  countryCode: Country two-character ISO 3166-1 alpha code.

  countryName: Country name.
  """
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

  @typedoc """
  sum: total number of sessions
  sessions: list of sessions
  """
  @type session_list_object :: %{
          sum: integer(),
          sessions: List[session_object]
        }

  @typedoc """

  event: Event name.

  ip: IP session in use when the session was created.

  time: Log creation time in Unix timestamp.

  osCode: Operating system code name. View list of available options.

  osName: Operating system name.

  osVersion: Operating system version.

  clientType: Client type.

  clientCode: Client code name.

  clientName: Client name.

  clientVersion: Client version.

  clientEngine: Client engine name.

  clientEngineVersion: Client engine name.

  deviceName: Device name.

  deviceBrand: Device brand name.

  deviceModel: Device model name.

  countryCode: Country two-character ISO 3166-1 alpha code.

  countryName: Country name.
  """
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
  Create a new user.
  """
  @spec create_user(String.t(), String.t(), String.t()) :: user_object | {:error, term()}
  def create_user(email, password, name \\ "") do
    payload =
      Jason.encode!(%{
        email: email,
        name: name,
        password: password
      })

    Generics.post(
      "http://#{@host}/v1/users",
      payload
    )
  end

  @doc """
  Get a list of all the project's users. You can use the query params to filter your results.
  """
  # dont foege to impletment query: %{page: 2}
  @spec get_all_users() :: List[user_object] | {:error, term()}
  def get_all_users() do
    Generics.get("http://#{@host}/v1/users")
  end

  @doc """
  Get a user by its unique ID.
  """
  @spec get_one_user(id: String.t()) :: user_object | {:error, term()}
  def get_one_user(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  @doc """
  Get the user preferences by its unique ID.
  """
  @spec get_user_prefs(String.t()) :: %{} | {:error, term()}
  def get_user_prefs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  @doc """
  Get the user sessions list by its unique ID.
  """
  @spec get_user_sessions(String.t()) :: session_list_object | {:error, term()}
  def get_user_sessions(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  @doc """
  Get a user activity logs list by its unique ID.
  """
  @spec get_user_logs(String.t()) :: List[log] | {:error, term()}
  def get_user_logs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/logs")
  end

  @doc """
  Update the user status by its unique ID.
  """
  @spec update_user_status(String.t(), boolean()) :: user_object | {:error, term()}
  def update_user_status(user_id, status) do
    payload =
      Jason.encode!(%{
        status: status
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/status",
      payload
    )
  end

  @doc """
  Update the user email verification status by its unique ID.
  """
  @spec update_user_email_verification(String.t(), boolean()) ::
          user_object | {:error, term()}
  def update_user_email_verification(user_id, status) do
    payload =
      Jason.encode!(%{
        emailVerification: status
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/verification",
      payload
    )
  end

  @doc """
  Update the user name by its unique ID.
  """
  @spec update_user_name(String.t(), String.t()) :: user_object | {:error, term()}
  def update_user_name(user_id, name) do
    payload =
      Jason.encode!(%{
        name: name
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/name",
      payload
    )
  end

  @doc """
  Update the user password by its unique ID.
  """
  @spec update_user_password(String.t(), String.t()) :: user_object | {:error, term()}
  def update_user_password(user_id, password) do
    payload =
      Jason.encode!(%{
        password: password
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/password",
      payload
    )
  end

  @doc """
  Update the user email by its unique ID.
  """
  @spec update_user_email(String.t(), String.t()) :: user_object | {:error, term()}
  def update_user_email(user_id, email) do
    payload =
      Jason.encode!(%{
        email: email
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/email",
      payload
    )
  end

  @doc """
  Update the user preferences by its unique ID. You can pass only the specific settings you wish to update.
  """
  @spec update_user_prefs(String.t(), %{}) :: user_object | {:error, term()}
  def update_user_prefs(user_id, prefs) do
    payload =
      Jason.encode!(%{
        prefs: Jason.encode!(prefs)
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{user_id}/prefs",
      payload
    )
  end

  @doc """
  Delete a user sessions by its unique ID.
  """
  @spec delete_user_session(String.t(), String.t()) :: %{} | {:error, term()}
  def delete_user_session(user_id, session_id) do
    Generics.delete("http://#{@host}/v1/users/#{user_id}/sessions/#{session_id}")
  end

  @doc """
  Delete all user's sessions by using the user's unique ID.
  """
  @spec delete_user_sessions(String.t()) :: nil | {:error, term()}
  def delete_user_sessions(user_id) do
    Generics.delete("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  @doc """
  Delete a user by its unique ID.
  """
  @spec(delete_user(String.t()) :: nil | :error, term())
  def delete_user(user_id) do
    Generics.delete("http://#{@host}/v1/users/#{user_id}")
  end
end
