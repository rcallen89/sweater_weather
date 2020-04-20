require 'rails_helper'

RSpec.describe 'Amypode API Service', type: :service do
  it 'can return a response successfully', :vcr do
    lat = "27"
    long = "-87"

    response = AmypodeService.get_antipode(lat, long)
    
    expect(response[:data][:attributes]).to have_key(:lat)
    expect(response[:data][:attributes]).to have_key(:long)
  end
end