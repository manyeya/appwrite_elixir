defmodule AppwriteElixir.Services.Accounts do
  alias AppwriteElixir.Services.Generics

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
end
