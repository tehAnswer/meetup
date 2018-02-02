task :environment do |_, args|
  require_relative 'lib/meetup'
end

desc 'Prints a list of possible attendees for a meeting given a maximum distance'
task :invite, [:max_radius, :file_path] => :environment do |_, args|
  puts Meetup.attendees_in(args[:max_radius].to_f, args[:file_path] || Dependencies[:file_path])
end
