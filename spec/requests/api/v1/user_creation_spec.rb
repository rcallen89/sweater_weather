require 'rails_helper'

RSpec.describe 'User POST requestion', type: :request do
  it 'will create a user when the proper params are sent' do
    user = {email: "example@example.com",
            password: "password",
            password_confirmation: "password"}

    post 'api/v1/users', params: user
  end
end