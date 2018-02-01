require "bundler/gem_tasks"
task :default => :spec

task :invite, [:max_radius] do |_, args|
  consumers = Dependencies[:parser].parse(ENV.fetch('CONSUMERS_FILE'))
  consumers_on_area = inviter.preselect(consumers, args.slice(:max_radius))
  table = Dependencies[:table_view].tap do |t|
    t.title = 'Invitations Sent'
    t.headers = ['ID', 'Name']
    t.rows = consumers_on_area.sort { |c1, c2| c1[:id] <=> c2[:id] }.map { |c| c.values_at(:id, :name) }
  end
  puts table
end
