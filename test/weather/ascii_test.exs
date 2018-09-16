defmodule Weather.AsciiTest do
  use ExUnit.Case
  doctest Weather.ASCII

  test "Generate Ascii art" do
    assert Weather.ASCII.pretty_print("123") == """
     __      _______    ______  
    /  \\    / ___   )  / ___  \\ 
    \\/) )   \\/   )  |  \\/   \\  \\
      | |       /   )     ___) /
      | |     _/   /     (___ ( 
      | |    /   _/          ) \\
    __) (_  (   (__/\\  /\\___/  /
    \\____/  \\_______/  \\______/ \n    \
    """
  end
end
