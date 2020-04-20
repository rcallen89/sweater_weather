class Api::V1::WeatherController < ApplicationController

  def show
    render json: ForecastSerializer.new(Forecast.new(params[:location]))
  end

end