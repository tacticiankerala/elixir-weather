defmodule Weather.CLITest do
  use ExUnit.Case
  import Weather.CLI

  test "parses -h as help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args([]) == :help
  end

  test "accepts the city name" do
    assert parse_args(["bangalore"]) == %{city: "bangalore"}
    assert parse_args(["Bangalore"]) == %{city: "bangalore"}
  end

end
