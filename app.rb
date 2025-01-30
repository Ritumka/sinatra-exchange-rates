require "sinatra"
require "sinatra/reloader"
require "json"
require "dotenv/load"
require "http"


get("/") do
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(exchange_rate_url)
  parsed_response = JSON.parse(raw_response)
  currencies_hash = parsed_response.fetch("currencies")
  @currencies = currencies_hash.keys

  erb(:homepage)
end

get("/:from_currency") do
  @the_symbol = params.fetch("from_currency")
  exchange_list_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(exchange_list_url)
  parsed_response = JSON.parse(raw_response)
  currencies_hash = parsed_response.fetch("currencies")
  @currencies = currencies_hash.keys

  erb(:step_one)
end

get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currency")
  @to = params.fetch("to_currency")
  exchange_rate_url = "https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(exchange_rate_url)
  pp parsed_response = JSON.parse(raw_response)
  @rate = parsed_response.fetch("result")
  

  erb(:step_two)
end
