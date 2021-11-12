defmodule AppwriteElixir do
  alias AppwriteElixir.Services.Accounts

  @moduledoc """
  Documentation for `AppwriteElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AppwriteElixir.hello()
      :world

  """
  # HTTPoison.start()

  def hello do
    Accounts.get_all_users()
  end

end
