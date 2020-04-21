require 'rails_helper'

RSpec.describe 'Google Direction Api', type: :service do
  it 'can return a response successfully', :vcr do
    origin = 'Denver, CO'
    destination = 'Pueblo, CO'

    response = DirectionService.get_directions(origin, destination)

    expect(response).to have_key(:duration)
    expect(response).to have_key(:end_location)
  end
end