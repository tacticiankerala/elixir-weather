defmodule Weather.Service do
  @weather_url_api "http://api.openweathermap.org/data/2.5/weather"
  @api_no_data_error "{\"message\":\"Error: Not found city\",\"cod\":\"404\"}\n"

  def fetch(city) do
    city
    |> weather_url
    |> HTTPoison.get
    |> parse_response
    |> extract_temperature
  end

  def weather_url(city, format \\ "xml", unit \\"metric") do
    "#{@weather_url_api}?q=#{city}&mode=#{format}&units=#{unit}"
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
    |> scan_data
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: 404}}) do
    IO.puts "No weather data is available for this city"
    System.halt(2)
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect reason
    System.halt(2)
  end

  def scan_data(@api_no_data_error) do
    IO.puts "No weather data is available for this city"
    System.halt(2)
  end

  def scan_data(xml_string) do
    xml_string
    |> Quinn.parse
    |> Quinn.find [:current, :temperature]
  end

  def extract_temperature([%{attr: [value: temperature, min: _, max: _, unit: _]}]) do
    temperature
  end
end
