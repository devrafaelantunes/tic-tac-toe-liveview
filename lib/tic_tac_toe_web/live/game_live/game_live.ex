defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:turn, "X")
      |> assign(:board, [
        "", #0
        "", #1
        "", #2
        "", #3
        "", #4
        "", #5
        "", #6
        "", #7
        "", #8
      ])
      |> assign(:winner, "")}

  end

  def handle_event("clicked", %{"num" => num}, socket) do
    check_winner(socket.assigns.board)

    if socket.assigns.turn == "X" do
      {:noreply,
      socket
      |> assign(:turn, "O")
      |> assign(:board, List.replace_at(socket.assigns.board, String.to_integer(num), "X"))
      |> assign(:winner, check_winner(socket.assigns.board))}
    else
      {:noreply,
      socket
      |> assign(:turn, "X")
      |> assign(:board, List.replace_at(socket.assigns.board, String.to_integer(num), "O"))
      |> assign(:winner, check_winner(socket.assigns.board))}
    end
  end

  def check_winner(board) do
    combinations = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]

    Enum.map(combinations, fn combination ->
      Enum.map(combination, fn number ->
        case Enum.at(board, number) do
          "X" -> "X"
          "O" -> "O"
          _ -> number
        end
      end)
    end)
    |> verify_winner()
  end

  def verify_winner(board) do
    Enum.reduce(board, "", fn combination, acc ->
      IO.inspect(combination)
      case combination do
        ["X", "X", "X"] -> acc = "X won"
        ["O", "O", "O"] -> acc = "O won"
        _ -> acc = "Draw"
      end
    end)
  end
end
