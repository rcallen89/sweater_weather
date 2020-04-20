class Antipode
  attr_reader :id,
              :search_location,
              :location_name,
              :forecast

  def initialize(location)
    # require 'pry'; binding.pry
    @id = nil
    @search_location = location
    @antipode_coords = get_antipode_coords(location)
    @location_name = antipode_reverse(@antipode_coords)
    @forecast = antipode_forecast(@antipode_coords)
  end

  def get_antipode_coords(location)
    sl_lat_lng = GeocodeService.location_response(location)
    AmypodeService.get_antipode(sl_lat_lng[:lat], sl_lat_lng[:lng])[:data][:attributes].slice(:lat, :long)
  end

  def antipode_reverse(coords)
    GeocodeService.get_city(coords)
  end

  def antipode_forecast(coords)
    forecast = OpenWeatherService.forecast_data(coords[:lat], coords[:long])[:current]
    {summary: forecast[:weather][0][:main], current_temperature: forecast[:temp]}
  end

end