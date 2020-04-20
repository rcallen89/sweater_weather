class Antipode
  attr_reader :id,
              :search_location

  def initialize(location)
    # require 'pry'; binding.pry
    @id = nil
    @search_location = location
    @antipode_coords = get_antipode_coords(location)
    @location_name = antipode_reverse(@antipode_coords)
    @forecast = antipode_forecast(@antipode_coords)
    require 'pry'; binding.pry
  end

  def get_antipode_coords(location)
    location_lat_long = GeocodeService.location_response(location)
    AmypodeService.get_antipode(location_lat_long[:lat], location_lat_long[:lng])[:data][:attributes].slice(:lat, :long)
  end

  def antipode_reverse(coords)
    GeocodeService.get_city(coords)
  end

  def antipode_forecast(coords)
    forecast = OpenWeatherService.forecast_data(coords[:lat], coords[:long])[:current]
    {summary: forecast[:weather][0][:main], current_temperature: forecast[:temp]}
  end


end