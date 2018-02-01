require 'colorize'
require 'oj'
require 'terminal-table'

require_relative 'config/dependencies'
Import = Dry::AutoInject(Dependencies)

require_relative 'lib/meetup'
