defmodule PongGame.GameManager do
  @game_finish 11
  def ready() do
    receive do
      {_sender, _action, @game_finish} ->
        IO.puts("Game finished...")
        ready()

      {sender, action, turn} ->
        hit_to(sender, switch(action), turn + 1)
        ready()
    after
      1_000 -> IO.puts("timing out player #{inspect(player_pid())}")
    end
  end

  def hit_to(opponent_pid, action, turn) do
    IO.puts("Turn: #{inspect(turn)}. hit to #{inspect(opponent_pid)} #{inspect(action)}")
    send(opponent_pid, {player_pid(), action, turn})
  end

  defp player_pid, do: self()

  defp switch(action) do
    case action do
      :ping -> :pong
      _ -> :ping
    end
  end
end

# player_1 = self

# # player_2 = spawn(PongGame.GameManager, :ready, [])
# player_2 = PongGame.GameManager |> Task.start(:ready, []) |> elem(1)

# PongGame.GameManager.hit_to(player_2, :ping, 1)

# PongGame.GameManager.ready()
