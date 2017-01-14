defmodule Darkskyx.Utils do
  @moduledoc false

  def api_key, do: Application.get_env(:darkskyx, :api_key)
  def defaults, do: :darkskyx |> Application.get_env(:defaults) |> Enum.into(%{})
  def user_agent, do: [{"User-agent", "Darkskyx"}]
  def compression, do: [{"Content-Encoding", "gzip"}]
  def request_headers, do: user_agent() ++ compression()
end
