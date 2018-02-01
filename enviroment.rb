require 'colorize'
require 'oj'
require 'terminal-table'
require 'dry-types'

require 'dry-struct'

module Types
  include Dry::Types.module
end

require_relative 'config/dependencies'
Import = Dry::AutoInject(Dependencies)

require_relative 'lib/meetup'
