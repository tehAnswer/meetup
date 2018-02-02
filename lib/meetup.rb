# NOTE: It sucks, but other matters! Inviter depends on the units refinement.
require_relative 'meetup/refinements/units'
require_relative 'meetup/inviter'
require_relative 'meetup/person'
require_relative 'meetup/parser'

module Meetup
  InvalidRadius = ArgumentError.new('The radius has to be a number.')

  def self.attendees_in(radius, file_path = Dependencies[:file_path])
    customer = Dependencies[:parser].parse(file_path)
    customer_on_area = Dependencies[:inviter].invite(customer, max_radius: radius)
    sorted_customers = customer_on_area.sort { |c1, c2| c1.user_id <=> c2.user_id }
    create_table(sorted_customers)
  end

  private

  def self.create_table(sorted_customers)
    customer_tuples = sorted_customers.map { |customer| [customer.user_id, customer.name] }
    Terminal::Table.new(title: 'Invited Customers', headings: %w(ID Name), rows: customer_tuples)
  end
end
