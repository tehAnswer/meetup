module Meetup
  module Refinements
    module Units
      # NOTE: Consider to add a shortcut for Strings as well.
      refine(Float) do
        def to_rad
          self * Math::PI / 180
        end
      end
    end
  end
end
