defmodule Darkskyx.Parser do
  @moduledoc """
  Generic parser to parse all the darksky api responses
  """

  @type status_code :: integer
  @type response ::
          {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map} | any

  @doc """
  Parses the response from darksky API calls
  """
  @spec parse(tuple) :: response
  def parse(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}}
      when status in [200, 201] ->
        {:ok, parse_success_response(body)}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 204}} ->
        :ok

      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:ok, json} = Poison.decode(body)
        {:error, json, status}

      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, %{reason: reason}}

      _ ->
        response
    end
  end

  defp parse_success_response(body) do
    body
    |> Poison.decode!()
  end
end
