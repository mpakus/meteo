# frozen_string_literal: true

class Address::UpdateWeather
  def initialize(address_id)
    @address_id = address_id
  end

  # @return [Address, false]
  def perform
    address = Address.find(address_id)
    client   = Weather::OpenMeteoClient.new(address.lat, address.lng)
    result   = client.perform

    return false if result.blank?

    address.weather.update(forecast: result)
    address
  end

  private

  attr_reader :address_id
end
