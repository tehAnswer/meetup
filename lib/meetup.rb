# NOTE: It sucks, but other matters! Inviter depends on the units refinement.
require_relative 'meetup/refinements/units'
require_relative 'meetup/inviter'
require_relative 'meetup/person'
require_relative 'meetup/parser'

module Meetup
  InvalidRadius = ArgumentError.new('The radius has to be a number.')
end
