require 'rails_helper'

RSpec.describe 'Google Geocode Api', type: :service do
  it 'can return a response successfully', :vcr do
    city = 'Austin, TX'

    response = GeocodeService.location_response(city)
    
    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)
  end
end