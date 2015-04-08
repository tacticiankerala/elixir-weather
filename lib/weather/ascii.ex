defmodule Weather.ASCII do
  def pretty_print(str) do
    str
    |> String.to_char_list
    |> convert_to_ascii_art
    |> IO.puts
  end

  def convert_to_ascii_art(list) do
    ascii_list = for char <- list, do: ascii_char(char)
    ascii_list_split = [head | tail] = Enum.map(ascii_list, &String.split(&1, "\n"))
    Enum.reduce(tail, head, fn val, acc -> Enum.zip(acc, val) |> Enum.map(fn {left, right} -> left <> "  " <>right end) end)
    |> Enum.join("\n")
  end

  def ascii_char(number) when (number - ?0) >= 0 and (number - ?0) <= 9 do
    {:ok , str} = File.read("ascii_chars.txt")
    Enum.at(String.split(str, "#\n"), number - ?0)
  end

  def ascii_char(?.) do
    {:ok , str} = File.read("ascii_chars.txt")
    List.last String.split(str, "#\n")
  end

end
