# frozen_string_literal: true

class DirectionService
  def self.connection
    Faraday.new('https://maps.googleapis.com')
  end

  def self.get_directions(origin, destination)
    response = connection.get('/maps/api/directions/json') do |call|
      call.params[:origin] = origin
      call.params[:destination] = destination
      call.params[:key] = ENV['GOOGLE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)[:routes][0][:legs][0].slice(:duration, :end_location)
  end
end
