# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: {  body: UserSerializer.new(user) }, status: 201
    else
      render json: {  body: user.errors.full_messages.to_sentence }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
