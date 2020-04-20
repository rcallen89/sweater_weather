require 'rails_helper'

RSpec.describe 'Antipode API Request', type: :request do
  it 'returns a correct json response based on a search city', :vcr do
    location = {location: "Hong Kong"}

    get "/api/v1/antipode", params: location
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes]).to have_key(:location_name)

    expect(parsed[:data][:attributes]).to have_key(:forecast)
    expect(parsed[:data][:attributes][:forecast]).to have_key(:summary)
    expect(parsed[:data][:attributes][:forecast]).to have_key(:current_temperature)

    expect(parsed[:data][:attributes]).to have_key(:search_location)
  end
end