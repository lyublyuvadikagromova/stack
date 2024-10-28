require 'minitest/autorun'
require 'csv'
require_relative 'task6'

class ExchangeRateTest < Minitest::Test
  def setup
    @base_currency = 'USD'
  end

  def test_fetch_exchange_rates
    response = fetch_exchange_rates(@base_currency)
    assert_equal "success", response["result"], "API request failed."
  end

  def test_data_processing
    response = fetch_exchange_rates(@base_currency)
    assert_includes response, "conversion_rates", "Data does not contain expected 'conversion_rates' field."
    assert response["conversion_rates"].is_a?(Hash), "conversion_rates is not a hash."
  end

  def test_csv_creation
    response = fetch_exchange_rates(@base_currency)
    save_to_csv(response, @base_currency)

    assert File.exist?("exchange_rates.csv"), "CSV file was not created."

    csv_content = CSV.read("exchange_rates.csv", headers: true)
    assert_equal ["Currency", "Rate"], csv_content.headers, "Headers in CSV file are incorrect."

    selected_currencies = ["EUR", "GBP", "JPY"]
    expected_data = selected_currencies.map { |currency| [currency, response["conversion_rates"][currency].to_s] }
    actual_data = csv_content.select { |row| selected_currencies.include?(row["Currency"]) }
                             .map { |row| [row["Currency"], row["Rate"]] }

    assert_equal expected_data, actual_data, "Data in CSV file does not match API response."
  end
end

