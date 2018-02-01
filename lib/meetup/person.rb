module Meetup
  class Person < Dry::Struct
    attribute :name,      Types::Strict::String
    attribute :user_id,   Types::Strict::Int
    attribute :latitude,  Types::Coercible::Float
    attribute :longitude, Types::Coercible::Float
  end
end
