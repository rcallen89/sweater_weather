require 'rails_helper'

RSpec.describe 'Session POST requestion', type: :request do
  it 'will return a user when the proper params are sent' do
    user = User.create!(email: "example@example.com",
            password: "password",
            password_confirmation: "password")

    passed_info = {email: "example@example.com",
                   password: "password"}

    post '/api/v1/sessions', params: passed_info

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)[:body]

    expect(parsed[:data][:attributes]).to have_key(:email)
    expect(parsed[:data][:attributes]).to have_key(:api_key)
  end

  it 'should return 400 error if not correct information is sent' do
    user = {email: "example@example.com",
            password: "password",
            password_confirmation: "password"}

    passed_info = {email: "example@example.com",
                   password: "password123"}

    post '/api/v1/sessions', params: passed_info

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:status]).to eq(400)
    expect(parsed[:body]).to eq("Bad Credentials")
  end
end