defmodule AppwriteElixir.Services.Generics do
  alias Jason

  @headers [
    "X-Appwrite-Project": "#{Application.get_env(:appwrite_elixir, :project_id)}",
    "X-Appwrite-Key": "#{Application.get_env(:appwrite_elixir, :api_key)}",
    Accept: "Application/json; Charset=utf-8"
  ]

  def get(url) do
    case HTTPoison.get(url, @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode!()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
