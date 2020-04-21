require 'rails_helper'

RSpec.describe 'Destination Forecast Request', type: :request do
  it 'can return json weather prediction based on destination and travel time', :vcr do
    user = User.create!(email: "example@example.com",
                        password: "password",
                        password_confirmation: "password")

    post '/api/v1/road_trip', params: {trip_data: {origin: "Denver, CO",
                                                   destination: "Pueblo, CO",
                                                   api_key: "#{user.api_key}"}}

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed[:body][:data][:attributes]).to have_key(:origin)
    expect(parsed[:body][:data][:attributes]).to have_key(:destination)
    expect(parsed[:body][:data][:attributes]).to have_key(:travel_time)
    expect(parsed[:body][:data][:attributes]).to have_key(:arrival_forcast)
  end

  it 'can return json weather prediction based on destination and travel time', :vcr do
    user = User.create!(email: "example@example.com",
                        password: "password",
                        password_confirmation: "password")

    post '/api/v1/road_trip', params: {trip_data: {origin: "Denver, CO",
                                                   destination: "Pueblo, CO"}}

    expect(response).not_to be_successful
  end
end