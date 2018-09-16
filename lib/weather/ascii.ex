defmodule Weather.ASCII do
  def pretty_print(str) do
    str
    |> String.to_charlist
    |> convert_to_ascii_art
  end

  def convert_to_ascii_art(list) do
    [head | tail] = list
                    |> Enum.map(&ascii_char/1)
                    |> Enum.map(&String.split(&1, "\n"))

    tail
    |> Enum.reduce(head, &join_char/2)
    |> Enum.join("\n")
  end

  defp join_char(val, acc) do
    acc
    |> Enum.zip(val)
    |> Enum.map(fn {left, right} -> left <> "  " <> right end)
  end

  defp ascii_char(number) when (number - ?0) >= 0 and (number - ?0) <= 9 do
    {:ok , str} = File.read("ascii_chars.txt")
    str
    |> String.split("#\n")
    |> Enum.at(number - ?0)
  end

  defp ascii_char(?.) do
    {:ok , str} = File.read("ascii_chars.txt")
    str
    |> String.split("#\n")
    |> List.last
  end

end
