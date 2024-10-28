require 'net/http'
require 'json'
require 'csv'

API_KEY = 'def286c5dd4b56e68afc798d'
BASE_URL = 'https://v6.exchangerate-api.com/v6'

def fetch_exchange_rates(base_currency)
  url = "#{BASE_URL}/#{API_KEY}/latest/#{base_currency}"
  puts "API request: #{url}"
  uri = URI(url)
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  else
    puts "Failed to retrieve exchange rates. Error status: #{response.code} #{response.message}"
    nil
  end
end

def save_to_csv(data, base_currency)
  CSV.open("exchange_rates.csv", "wb") do |csv|
    csv << ["Currency", "Rate"]
    data["conversion_rates"].each do |currency, rate|
      csv << [currency, rate]
    end
  end
end

base_currency = 'USD'
exchange_data = fetch_exchange_rates(base_currency)

if exchange_data && exchange_data["result"] == "success"
  puts "Exchange rates retrieved successfully!"
  save_to_csv(exchange_data, base_currency)
  puts "Data saved to exchange_rates.csv file"
else
  puts "Error"
end


