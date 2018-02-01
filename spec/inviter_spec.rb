RSpec.describe Meetup::Inviter do
  before do
    Dependencies.stub(:lat_origin, 53.339428)
    Dependencies.stub(:lon_origin, -6.257664)
  end

  after do
    Dependencies.unstub(:lat_origin)
    Dependencies.unstub(:lon_origin)
  end

  let(:people) do
    [
      # Someone far away from the radius
      Meetup::Person.new(user_id: 1, name: 'Sergio', latitude: 52.365091, longitude: 4.925845),
      # Someone in the radius and nearby
      Meetup::Person.new(user_id: 2, name: 'Conor', latitude: 53.328430, longitude: -6.304864),
      # Someone in the radius near to the limit
      Meetup::Person.new(user_id: 3, name: 'Colin', latitude: 52.865386, longitude: -6.558605),
      # Someone outside of the radius for a few kilometers
      Meetup::Person.new(user_id: 4, name: 'Wiston', latitude: 53.22899, longitude: -4.519761)
    ]
  end

  subject { Dependencies[:inviter].invite(people, max_radius: max_radius) }

  context 'filters by distance' do
    let(:max_radius) { 100 }
    it { is_expected.to include(people[1]) }
    it { is_expected.to include(people[2]) }
  end

  context 'raises error if max_radius is not a number' do
    let(:max_radius) { :foo }
    it do
      expect { subject }.to raise_error(Meetup::InvalidRadius)
    end
  end

  context 'does not return any result if max_radius is zero' do
    let(:max_radius) { 0 }
    it { is_expected.to be_empty }
  end
end
