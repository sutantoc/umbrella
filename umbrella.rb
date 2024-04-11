require "http"
require "json"

line_width = 40

puts "=" * line_width
puts "Will you need an umbrella today?"
puts "=" * line_width
puts "Where are you?"
location = gets
puts "Checking the weather at #{location}"

gmaps_key = ENV["GMAPS_KEY"]
pirate_weather_key = ENV["PIRATE_WEATHER_KEY"]

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_key}"

raw_gmaps = HTTP.get(gmaps_url)
parsed_gmaps = JSON.parse(raw_gmaps)
results_array = parsed_gmaps.fetch("results")
first_result_hash = results_array.at(0)
geometry_hash = first_result_hash.fetch("geometry")
location_hash = geometry_hash.fetch("location")
latitude = location_hash.fetch("lat")
longitude = location_hash.fetch("lng")

puts "Your coordinates are #{latitude}, #{longitude}."

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{latitude},#{longitude}"

raw_pirate_weather_data = HTTP.get(pirate_weather_url)
parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)
currently_hash = parsed_pirate_weather_data.fetch("currently")
current_temp = currently_hash.fetch("temperature")

puts "It is currently #{current_temp}°F."
