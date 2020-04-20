require 'rails_helper'

RSpec.describe 'Forecast responses' do
  it 'can return a json response if location is sent', :vcr do
    location = {location: "Austin, TX"}
    
    get '/api/v1/forecast', params: location
    expect(response).to be_successful
    
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes]).to have_key(:current_weather)

    # Test inclusion of 7 day forecast
    expect(parsed[:data][:attributes]).to have_key(:daily_weather)
    expect(parsed[:data][:attributes][:daily_weather].length).to eq(7)

    # Test inclusion of 8 hourly forecast
    expect(parsed[:data][:attributes]).to have_key(:hourly_weather)
    expect(parsed[:data][:attributes][:hourly_weather].length).to eq(8)
  end
end