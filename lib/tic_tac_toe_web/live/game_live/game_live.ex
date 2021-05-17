defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  @combinations [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

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
      |> assign(:board, List.replace_at(socket.assigns.board, String.to_integer(num), board))
      |> assign(:board_status, List.replace_at(socket.assigns.board_status, String.to_integer(num), "disabled"))
      |> assign(:winner, check_winner(List.replace_at(socket.assigns.board, String.to_integer(num), board)))}
  end

  def check_winner(board) do
    Enum.map(@combinations, fn combination ->
      Enum.map(combination, fn number ->
        case Enum.at(board, number) do
          "X" -> "X"
          "O" -> "O"
          _ -> number
        end
      end)
    end)

    |> verify_winner(board)
  end

  def verify_winner(combinations, board) do
    result = Enum.reduce(combinations, "", fn x, acc ->
      case x do
        ["X", "X", "X"] -> "X won" <> acc
        ["O", "O", "O"] -> "O won" <> acc
        _ -> acc
      end
    end)

    if result == "" do
      verify_draw(board)
    else
      result
    end
  end

  def verify_draw(board) do
    string_list = List.to_string(board)

    if String.length(string_list) == 9 do
      "Draw"
    else
      ""
    end
  end
end
