defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Game

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:started?, false)
      |> assign(:turn, "")
      |> assign(:board, ["", "", "", "", "", "", "", "", ""])
      |> assign(:button_status, ["", "", "", "", "", "", "", "", ""])
      |> assign(:winner, "")}

  end

  def handle_event("game_click", %{"num" => num}, socket) do
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
      |> assign(:button_status, change_button_status(socket, num))
      |> assign(:winner, Game.fill_combinations(change_board(socket, num, board)))}
  end

  def handle_event("start_game", %{"symbol" => symbol}, socket) do
    {:noreply,
      socket
      |> assign(:started?, true)
      |> assign(:turn, symbol)}
  end

  def display_color(board, position) do
    if Enum.at(board, position) == "X" do
      "color: red;"
    else
      "color: blue;"
    end
  end

  defp change_board(socket, num, param), do: List.replace_at(socket.assigns.board, String.to_integer(num), param)
  defp change_button_status(socket, num), do: List.replace_at(socket.assigns.button_status, String.to_integer(num), "disabled")
end
