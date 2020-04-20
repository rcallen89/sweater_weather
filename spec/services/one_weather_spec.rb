require 'rails_helper'

RSpec.describe 'One Weather Api', type: :service do
  it 'can return a response successfully', :vcr do
    lat = 30.267153
    lon = -97.743057

    response = OpenWeatherService.forecast_data(lat, lon)
    expect(response).to have_key(:current)
    expect(response).to have_key(:hourly)
    expect(response).to have_key(:daily)
  end
end