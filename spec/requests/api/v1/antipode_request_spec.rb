require 'rails_helper'

RSpec.describe 'Antipode API Request', type: :request do
  it 'returns a correct json response based on a search city', :vcr do
    location = {location: "Hong Kong"}

    get "/api/v1/antipode", params: location

    require 'pry'; binding.pry
  end
end