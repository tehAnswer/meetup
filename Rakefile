require "bundler/gem_tasks"
task :default => :spec

task :environment do |_, args|
  require_relative 'environment'
end

task :invite, [:max_radius, :file_path] => :environment do |_, args|
  puts Meetup.attendees_in(args[:max_radius], args[:file_path])
end
