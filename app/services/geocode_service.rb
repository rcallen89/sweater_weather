class GeocodeService

  def self.connection
    conn = Faraday.new("https://maps.googleapis.com/")
  end

  def self.location_response(city)
    response = connection.get("/maps/api/geocode/json") do |call|
      call.params[:components] = "locality:#{city}"
      call.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0][:geometry][:location]
  end

  def self.get_city(coords)
    response = connection.get("/maps/api/geocode/json") do |call|
      call.params[:latlng] = coords.values.join(", ")
      call.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0][:address_components][1][:long_name]
  end
end