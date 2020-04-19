class OpenWeatherService

  def initialize
    conn = Faraday.new("https://api.openweathermap.org")
  end

  def forecast_data(lat, lon)
    response = conn.get("/data/2.5/onecall") do |call|
      call.params[:lat] = lat
      call.params[:lon] = lon
      call.params[:appid] = ENV['OPEN_WEATHER_ONE']
    end
  end

# /data/2.5/onecall?lat=30.267153&lon=-97.743057&units=imperial&appid=0d9db90190c8ab1f18480a01aac48791

end