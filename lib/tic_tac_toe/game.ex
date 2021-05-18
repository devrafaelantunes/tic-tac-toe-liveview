defmodule TicTacToe.Game do

  @winning_combinations [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def fill_combinations(board) do
    Enum.map(@winning_combinations, fn combination ->
      Enum.map(combination, fn number ->
        case Enum.at(board, number) do
          "X" -> "X"
          "O" -> "O"
          _ -> number
        end
      end)
    end)
    |> winner?(board)
  end

  defp winner?(combinations, board) do
    result =
      Enum.reduce(combinations, "", fn x, acc ->
        case x do
          ["X", "X", "X"] -> "X" <> acc
          ["O", "O", "O"] -> "O" <> acc
          _ -> acc
        end
      end)

    if result == "" do
      draw?(board)
    else
      result
    end
  end

  defp draw?(board) do
    string_list = List.to_string(board)

    if String.length(string_list) == 9 do
      "No one "
    else
      ""
    end
  end
end
