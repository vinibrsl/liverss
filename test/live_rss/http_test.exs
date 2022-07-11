defmodule LiveRSS.HTTPTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  test "get/1 returns feed" do
    assert {:ok, feed} =
             LiveRSS.HTTP.get("https://rss.nytimes.com/services/xml/rss/nyt/World.xml")

    assert %FeederEx.Feed{title: "NYT > World News"} = feed
  end

  test "get/1 when body is not rss returns error" do
    assert capture_log(fn ->
             assert :error = LiveRSS.HTTP.get("https://google.com/")
           end) =~ "LiveRSS: failed to get feed. Reason: {:fatal_error"
  end

  test "get/1 when request fails returns error" do
    assert capture_log(fn ->
             assert :error = LiveRSS.HTTP.get("invalid domain")
           end) =~ "LiveRSS: failed to get feed. Reason: {:error, :invalid_uri}"
  end
end
