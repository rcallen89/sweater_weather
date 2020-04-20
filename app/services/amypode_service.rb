class AmypodeService

  def self.connection
    Faraday.new("http://amypode.herokuapp.com")
  end

  def self.get_antipode(lat, long)
    response = connection.get("/api/v1/antipodes") do |call|
      call.headers[:api_key] = ENV['AMYPODE_API_KEY']
      call.params[:lat] = lat
      call.params[:long] = long
    end
    JSON.parse(response.body, symbolize_names: true)
  end


end

#  http://amypode.herokuapp.com/api/v1/antipodes?lat=27&long=-82