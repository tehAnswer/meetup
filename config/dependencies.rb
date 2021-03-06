require 'dry/container'
require 'dry/auto_inject'

class Dependencies
  extend Dry::Container::Mixin

  register(:parser)     { Meetup::Parser.new  }
  register(:logger)     { Logger.new($stdout) }
  register(:inviter)    { Meetup::Inviter.new }

  register(:lat_origin) { ENV['COORDINATES'].split(', ').first.to_f }
  register(:lon_origin) { ENV['COORDINATES'].split(', ').last.to_f  }
  register(:file_path)  { File.expand_path('../people.json', __FILE__) }
end
