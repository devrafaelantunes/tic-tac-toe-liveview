defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Game

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:turn, "X")
      |> assign(:board, ["", "", "", "", "", "", "", "", ""])
      |> assign(:board_status, ["", "", "", "", "", "", "", "", ""])
      |> assign(:winner, "")}
  end

  def handle_event("clicked", %{"num" => num}, socket) do
    if socket.assigns.turn == "X" do
      handle_reply(socket, num, "O", "X")
    else
      handle_reply(socket, num, "X", "O")
    end
  end

  def handle_reply(socket, num, turn, board) do
    {:noreply,
      socket
      |> assign(:turn, turn)
      |> assign(:board, change_board(socket, num, board))
      |> assign(:board_status, change_board_status(socket, num))
      |> assign(:winner, Game.fill_combinations(change_board(socket, num, board)))}
  end

  defp change_board(socket, num, param), do: List.replace_at(socket.assigns.board, String.to_integer(num), param)
  defp change_board_status(socket, num), do: List.replace_at(socket.assigns.board_status, String.to_integer(num), "disabled")
end
