defmodule Identicon do
  def main(input) do
    input
    |> has_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex}) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirrow_row/1)
  end

  def mirrow_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def has_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
