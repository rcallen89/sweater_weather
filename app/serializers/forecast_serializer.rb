# frozen_string_literal: true

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current_weather, :hourly_weather, :daily_weather
end
