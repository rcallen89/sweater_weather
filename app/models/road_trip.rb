# frozen_string_literal: true

class RoadTrip
  attr_reader :origin,
              :destination,
              :travel_time,
              :arrival_forcast,
              :id

  def initialize(trip_data)
    @id = nil
    @origin = trip_data[:origin]
    @destination = trip_data[:destination]
    @trip_stats = trip_stats(trip_data)
    @travel_time = @trip_stats[:duration][:text]
    @arrival_forcast = destination_forecast(@trip_stats)
  end

  def trip_stats(trip_data)
    DirectionService.get_directions(trip_data[:origin], trip_data[:destination])
  end

  def destination_forecast(trip_stats)
    lat_long = trip_stats[:end_location]
    travel_time = (trip_stats[:duration][:value] / 3600.00).round
    forecasted_hour = OpenWeatherService.forecast_data(lat_long[:lat], lat_long[:lng])[:hourly][travel_time + 1]
    [forecasted_hour[:temp], forecasted_hour[:weather][0][:main]]
  end
end
