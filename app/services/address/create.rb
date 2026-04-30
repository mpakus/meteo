# frozen_string_literal: true

class Address::Create
  def initialize(full, lat, lng, zip)
    @full = full
    @lat  = lat
    @lng  = lng
    @zip  = zip
  end

  # Creates an address record with the given full address, latitude, longitude, and zip code.
  # If the zip code does not exist in the database, it will be created as well.
  #
  # @return [Address]
  def perform
    ActiveRecord::Base.transaction do
      weather = Weather.find_or_create_by!(zip:)

      address = Address.find_or_create_by!(full:) do |addr|
        addr.lat     = @lat
        addr.lng     = @lng
        addr.weather = weather
      end
      { address: address }
    end
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end

  private

  attr_reader :full, :lat, :lng, :zip
end
