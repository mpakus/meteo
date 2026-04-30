# frozen_string_literal: true

class WeatherDecorator < SimpleDelegator
  # @return [String]
  def state
    code = forecast&.fetch('weathercode', '')
    return '' if code.blank?

    I18n.t("weather.codes.#{code}", default: '')
  end

  # @return [String]
  def temperature
    temperature = forecast&.fetch('temperature', '')&.round(1)
    return '' if temperature.blank?

    I18n.t(
      'weather.temperature.fahrenheit',
      temperature:,
      default: ''
    )
  end
end
