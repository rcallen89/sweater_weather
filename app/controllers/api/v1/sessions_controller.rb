# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user &.authenticate(params[:session][:password])
      render json: {  body: UserSerializer.new(user) }, status: 200
    else
      render json: {  body: 'Bad Credentials' }, status: 400
    end
  end
end
