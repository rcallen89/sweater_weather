require 'rails_helper'

RSpec.describe 'Background Image Api', type: :service do
  it 'can return a response successfully', :vcr do
    location = 'Austin, TX'

    response = BackgroundService.get_image(location)

    expect(response[:results][0]).to have_key(:urls)

  end
end