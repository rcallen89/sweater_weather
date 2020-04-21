# frozen_string_literal: true

class Api::V1::BackgroundController < ApplicationController
  def show
    Rails.cache.fetch("background_for_#{params[:location]}", expires_in: 24.hours) do
      render json: BackgroundSerializer.new(Background.new(params[:location]))
    end
  end
end
