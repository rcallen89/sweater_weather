# frozen_string_literal: true

class BackgroundService
  def self.connection
    conn = Faraday.new('https://api.unsplash.com')
  end

  def self.get_image(location)
    response = connection.get('/search/photos') do |call|
      call.params[:query] = location.split(',').first.to_s
      call.params[:client_id] = ENV['UNSPLASH_ACCESS_KEY']
      call.params[:per_page] = '1'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
