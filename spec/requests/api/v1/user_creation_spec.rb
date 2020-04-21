require 'rails_helper'

RSpec.describe 'User POST requestion', type: :request do
  it 'will create a user when the proper params are sent' do


    post '/api/v1/users', params: {user: {email: "example@example.com",
                                          password: "password",
                                          password_confirmation: "password"}}

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)[:body]

    expect(parsed[:data][:attributes]).to have_key(:email)
    expect(parsed[:data][:attributes]).to have_key(:api_key)
  end

  it 'should return 400 error if not correct information is sent' do
    post '/api/v1/users', params: {user: {email: "example@example.com",
                                          password: "password",
                                          password_confirmation: "password123"}}

    expect(response).not_to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:body]).to eq("Password confirmation doesn't match Password")
  end
end