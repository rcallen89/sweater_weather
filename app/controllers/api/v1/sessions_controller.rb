class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])
    if user &.authenticate(params[:session][:password])
      render json: {status: 200, body: UserSerializer.new(user)}
    else
      render json: {status: 400, body: "Bad Credentials"}
    end
  end
end