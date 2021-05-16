defmodule TicTacToeWeb.GameLive do
  use TicTacToeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:turn, "X")
      |> assign(:board, %{
        zero: "",
        one: "",
        two: "",
        three: "",
        four: "",
        five: "",
        six: "",
        seven: "",
        eight: "" })}
  end

  def handle_event("clicked", %{"num" => num}, socket) do
    IO.inspect(check_winner(socket.assigns.board))

    if socket.assigns.turn == "X" do
      {:noreply,
      socket
      |> assign(:turn, "O")
      |> assign(:board, Map.replace(socket.assigns.board, String.to_atom(num), "X"))}
    else
      {:noreply,
      socket
      |> assign(:turn, "X")
      |> assign(:board, Map.put(socket.assigns.board, String.to_atom(num), "O"))}
    end
  end

  def check_winner(board) do
    combinations = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,2,6],
      [1,4,6],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]


    Enum.map(combinations, fn combination ->
      Enum.map(combination, fn number ->
        number
      end)
    end)
  end
end
