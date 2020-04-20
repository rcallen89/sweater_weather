require 'rails_helper'

RSpec.describe 'Background Image Api', type: :service do
  it 'can return a response successfully', :vcr do
    location = {location: 'Austin, TX'}

    response = BackgroundService.get_image(location)

  end
end