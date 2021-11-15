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
  Create a new user.
  """
  # @spec create_new_user(email: String.t(), name: String.t(), password: String.t()) :: user_object | {:error, term()}
  def create_user(email, name \\ "", password) do
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
  @spec get_user_prefs(id: String.t()) :: %{} | {:error, term()}
  def get_user_prefs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}")
  end

  @doc """
  Get the user sessions list by its unique ID.
  """
  @spec get_user_sessions(id: String.t()) :: session_list_object | {:error, term()}
  def get_user_sessions(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  @doc """
  Get a user activity logs list by its unique ID.
  """
  @spec get_user_logs(id: String.t()) :: List[log] | {:error, term()}
  def get_user_logs(user_id) do
    Generics.get("http://#{@host}/v1/users/#{user_id}/logs")
  end

  @doc """
  Update the user status by its unique ID.
  """
  defmodule UpdateUserStatusInputs do
    defstruct user_id: "", status: false
    @type t :: %__MODULE__{user_id: String.t(), status: boolean()}
  end

  @spec update_user_status(UpdateUserStatusInputs) :: user_object | {:error, term()}
  def update_user_status(input) do
    payload =
      Jason.encode!(%{
        status: input.status
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/status",
      payload
    )
  end

  @doc """
  Update the user email verification status by its unique ID.
  """
  defmodule UpdateEmailVerificationInputs do
    defstruct user_id: "", status: false
    @type t :: %UpdateEmailVerificationInputs{user_id: String.t(), status: boolean()}
  end

  @spec update_user_email_verification(UpdateEmailVerificationInputs.t()) ::
          user_object | {:error, term()}
  def update_user_email_verification(input) do
    payload =
      Jason.encode!(%{
        emailVerification: input.status
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/verification",
      payload
    )
  end

  @doc """
  Update the user name by its unique ID.
  """
  defmodule UpdateUserNameInputs do
    defstruct user_id: "", name: ""
    @type t :: %UpdateUserNameInputs{user_id: String.t(), name: String.t()}
  end

  @spec update_user_name(UpdateUserNameInputs.t()) :: user_object | {:error, term()}
  def update_user_name(input) do
    payload =
      Jason.encode!(%{
        name: input.name
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/name",
      payload
    )
  end

  @doc """
  Update the user password by its unique ID.
  """
  defmodule UpdateUserPasswordInputs do
    defstruct user_id: "", password: ""
    @type t :: %UpdateUserPasswordInputs{user_id: String.t(), password: String.t()}
  end

  @spec update_user_password(UpdateUserPasswordInputs.t()) :: user_object | {:error, term()}
  def update_user_password(input) do
    payload =
      Jason.encode!(%{
        password: input.password
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/password",
      payload
    )
  end

  defmodule UpdateUserEmailInputs do
    defstruct user_id: "", email: ""
    @type t :: %UpdateUserEmailInputs{user_id: String.t(), email: String.t()}
  end

  @spec update_user_email(UpdateUserEmailInputs.t()) :: user_object | {:error, term()}
  def update_user_email(input) do
    payload =
      Jason.encode!(%{
        password: input.email
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/email",
      payload
    )
  end

  @doc """
  Update the user preferences by its unique ID. You can pass only the specific settings you wish to update.
  """
  defmodule UpdateUserPrefsInputs do
    defstruct user_id: "", prefs: %{}
    @type t :: %UpdateUserPrefsInputs{user_id: String.t(), prefs: %{}}
  end

  @spec update_user_prefs(UpdateUserPrefsInputs.t()) :: user_object | {:error, term()}
  def update_user_prefs(input) do
    payload =
      Jason.encode!(%{
        prefs: Jason.encode!(input.prefs)
      })

    Generics.patch(
      "http://#{@host}/v1/users/#{input.user_id}/prefs",
      payload
    )
  end

  @doc """
  Delete a user sessions by its unique ID.
  """
  defmodule DeleteUserSessionInputs do
    defstruct user_id: "", session_id: ""
    @type t :: %DeleteUserSessionInputs{user_id: String.t(), session_id: String.t()}
  end

  @spec delete_user_session(DeleteUserSessionInputs.t()) :: nil | {:error, term()}
  def delete_user_session(input) do
    Generics.delete("http://#{@host}/v1/users/#{input.user_id}/sessions/#{input.session_id}")
  end

  @doc """
  Delete all user's sessions by using the user's unique ID.
  """
  @spec delete_user_sessions(id: String.t()) :: nil | {:error, term()}
  def delete_user_sessions(user_id) do
    Generics.delete("http://#{@host}/v1/users/#{user_id}/sessions")
  end

  @doc """
  Delete a user by its unique ID.
  """
  @spec delete_user(id: String.t()) :: nil | :error, term()
  def delete_user(user_id) do
    Generics.delete("http://#{@host}/v1/users/#{user_id}")
  end
end
