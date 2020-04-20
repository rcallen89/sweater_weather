class Forecast
  attr_reader :id,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(location)
    @id = nil
    @forecast = retrieve_forecast(location)
    @current_weather = current(@forecast[:current], @forecast[:daily][0])
    @hourly_weather = hourly(@forecast[:hourly][2..9])
    @daily_weather = daily(@forecast[:daily][1..7])
  end

  def retrieve_forecast(location)
    geocode_data = GeocodeService.location_response(location)
    weather_data = OpenWeatherService.forecast_data(geocode_data[:lat], geocode_data[:lng])
  end

  def current(current_weather, day_stats)
    min_max = day_stats[:temp].slice(:min, :max)
    current_info = current_weather.slice(:dt, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :weather)
    current_info.merge(min_max)
  end

  def hourly(hourly_weather)
    hourly_weather.reduce(Hash.new) do |acc, hour|
      acc[hour[:dt]] = hour.slice(:temp, :weather)
      acc
    end
  end

  def daily(daily_weather)
    daily_weather.reduce(Hash.new()) do |acc, day|
      acc[day[:dt]] = {
        high_temp: day[:temp][:max],
        low_temp: day[:temp][:min],
        weather: day[:weather],
        rain: day[:rain]
      }
      acc
    end
  end

end