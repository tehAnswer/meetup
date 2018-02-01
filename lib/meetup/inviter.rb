module Meetup
  class Inviter
    include Import[:lat_origin]
    include Import[:lon_origin]
    using Meetup::Refinements::Units
    include Math

    EARTH_RADIUS = 6_371

    def invite(people, max_radius:)
      raise Meetup::InvalidRadius unless max_radius.respond_to?(:to_f)
      people.select do |person|
        person_distance = distance lat1: person[:latitude].to_rad,
                                   lat2: lat_origin.to_rad,
                                   lon1: person[:longitude].to_rad,
                                   lon2: lon_origin.to_rad
        max_radius >= person_distance
      end
    end

    private

    def distance(lat1:, lat2:, lon1:, lon2:)
      delta_lon = (lat2 - lat1).abs

      factor1 = (cos(lat2) * sin(delta_lon)) ** 2
      factor2 = (cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(delta_lon)) ** 2
      denominator = sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(delta_lon)

      delta_lat = atan2(sqrt(factor1 + factor2), denominator)
      EARTH_RADIUS * delta_lat
    end
  end
end
