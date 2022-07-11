defmodule LiveRSS.HTTP do
  @moduledoc """
  This module defines functions to make HTTP requests.
  """

  require Logger

  @spec get(String.t()) :: {:ok, %FeederEx.Feed{}} | :error
  @doc """
  Returns a %FeederEx.Feed{} struct from a RSS feed URL. Returns {:ok, %FeederEx.Feed{}} or
  logs the error returning :error.
  """
  def get(feed_url) do
    with {:ok, {{_, status, _}, _headers, body}} <- :httpc.request(feed_url),
         status when status in 200..299 <- status,
         {:ok, %FeederEx.Feed{} = feed, _} <- FeederEx.parse(body) do
      {:ok, feed}
    else
      error ->
        Logger.error("LiveRSS: failed to get feed. Reason: #{inspect(error)}")
        :error
    end
  end
end
