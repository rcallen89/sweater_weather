# frozen_string_literal: true

class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:trip_data][:api_key])
      render json: { body: RoadTripSerializer.new(RoadTrip.new(params[:trip_data])) }, status: 200
    else
      render json: { body: 'Unauthorized' }, status: 401
    end
  end
end
