# frozen_string_literal: true

class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image_url
end
