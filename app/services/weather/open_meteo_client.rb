# frozen_string_literal: true

class Weather::OpenMeteoClient
  URL = 'https://api.open-meteo.com/v1/forecast'

  attr_reader :error, :status

  def initialize(latitude, longitude)
    @latitude  = latitude
    @longitude = longitude
    @status    = nil
    @error     = nil
  end

  def perform
    case request?
    in { ok: data }
      @status = :ok
      data.dig('current_weather')
    in { error: }
      @error  = error.dig(:body)
      @status = error.dig(:status)
      nil
    end
  end

  private

  attr_reader :latitude, :longitude

  def request?
    response = HTTParty.get(url)
    if response.success?
      { ok: response.parsed_response }
    else
      { error: { status: response.code, body: response.body } }
    end
  rescue StandardError => e
    { error: { status: :exception, body: e.message } }
  end

  def url
    "#{URL}?#{params.to_query}"
  end

  def params
    {
      latitude:,
      longitude:,
      temperature_unit: 'fahrenheit',
      current_weather:  true
    }
  end
end
