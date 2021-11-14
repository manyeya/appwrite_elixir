defmodule AppwriteElixir.Services.Generics do
  alias Jason

  @headers [
    {"Content-Type", "application/json"},
    {"X-Appwrite-Project", "#{Application.get_env(:appwrite_elixir, :project_id)}"},
    {"X-Appwrite-Key", "#{Application.get_env(:appwrite_elixir, :api_key)}"}
  ]

  def get(url) do
    case HTTPoison.get(url, @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode!()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def post(url, payload) do
    case HTTPoison.post(url, payload, @headers) do
      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        body |> Jason.decode!()

      {:ok, %HTTPoison.Response{status_code: 401}} ->
        IO.puts("Access Denied")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
