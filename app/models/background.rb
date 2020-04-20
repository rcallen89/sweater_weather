# frozen_string_literal: true

class Background
  attr_reader :image_url, :id

  def initialize(location)
    @id = nil
    @image_url = get_image_url(location)
  end

  def get_image_url(location)
    BackgroundService.get_image(location)[:results][0][:urls][:raw]
  end
end
