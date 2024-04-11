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

# pp "It is currently XXXX"
