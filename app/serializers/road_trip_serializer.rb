# frozen_string_literal: true

class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :travel_time, :arrival_forcast
end
