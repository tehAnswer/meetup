module Meetup
  class Inviter
    include Import['max_radius']
    include Import['lat_origin']
    include Import['lon_origin']
    using Radians

    def call(people)
      people.select do |person|
        max_radius >= distance(lat1: person[:latitude].to_rad, lat2: lat_origin.to_rad, lon1: person[:longitude].to_rad, lon2: lon_origin.to_rad)
      end.map { |person| person.slice(:id, :name) }
    end

    private

    def distance(lat1:, lat2:, lat3:, lat4:)
      delta_lon = (lon2 - lon1).abs
      delta_lat = Math.acos(Math.sin(lat1) * Math.sin(lat2) + Math.cos(lon1) * Math.cos(lon2) * Math.cos(delta_lon))
      max_radius * delta_lat
    end
  end
end
