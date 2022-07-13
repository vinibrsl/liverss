defmodule LiveRSS.PollTest do
  use ExUnit.Case

  test "start_link/1 validates uri without scheme" do
    assert {:error, :invalid_url} =
             LiveRSS.Poll.start_link(url: "example.test/feed.rss", name: :test)
  end

  test "start_link/1 validates name" do
    assert {:error, :invalid_name} =
             LiveRSS.Poll.start_link(url: "https://example.test/feed.rss", name: "invalid")
  end

  test "start_link/1 starts a new process" do
    assert {:ok, pid} =
             LiveRSS.Poll.start_link(url: "https://example.test/feed.rss", name: :rss_example)

    assert Process.alive?(pid)
    Process.exit(pid, :normal)
  end

  test "start_link/1 polls feed periodically" do
    assert {:ok, pid} =
             LiveRSS.Poll.start_link(
               url: "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
               name: :rss_nyt,
               refresh_every: 100
             )

    :erlang.trace(pid, true, [:receive])
    assert_receive {:trace, ^pid, :receive, :poll}, 150
    assert %FeederEx.Feed{} = LiveRSS.Poll.get(:rss_nyt)
    Process.exit(pid, :normal)
  end

  test "get/1 returns feed" do
    assert {:ok, pid} =
             LiveRSS.Poll.start_link(
               url: "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
               name: :rss_nyt
             )

    assert %FeederEx.Feed{} = LiveRSS.Poll.get(:rss_nyt)
    Process.exit(pid, :normal)
  end
end
