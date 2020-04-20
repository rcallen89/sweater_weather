require 'rails_helper'

RSpec.describe 'background responses' do
  it 'can return a json response url if location is sent', :vcr do
    location = {location: "Austin, TX"}
    
    get '/api/v1/backgrounds', params: location
    expect(response).to be_successful
    
    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:data][:attributes]).to have_key(:image_url)
  end
end