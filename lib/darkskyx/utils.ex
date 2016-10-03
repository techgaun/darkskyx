defmodule Darkskyx.Utils do
  @moduledoc false

  def api_key, do: Application.get_env(:darkskyx, :api_key)
  def unit, do: Application.get_env(:darkskyx, :unit) || "auto"
  def lang, do: Application.get_env(:darkskyx, :lang) || "en"
  def user_agent, do: [{"User-agent", "Darkskyx"}]
end
