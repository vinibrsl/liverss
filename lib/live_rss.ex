defmodule LiveRSS do
  defdelegate get(process_name), to: LiveRSS.Poll
end
