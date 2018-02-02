RSpec.describe Meetup::Parser do
  include_context 'silent logger'
  let(:instance) { Dependencies[:parser] }

  subject { instance.parse(file_path) }
  context 'parse a valid file' do
    let(:people) do
      [
        Meetup::Person.new(latitude: 52.986375, user_id: 0, name: "Foo", longitude: -6.043701),
        Meetup::Person.new(latitude: 51.92893, user_id: 1, name: "Bar", longitude: -10.27699),
        Meetup::Person.new(latitude: 52.986375, user_id: 3, name: "Foo", longitude: -6.043701)
      ]
    end

    let(:file_path) { File.expand_path('../support/file_users.txt', __FILE__) }

    it { expect(subject.length).to eq(3)   }
    it { is_expected.to include(people[0]) }
    it { is_expected.to include(people[1]) }
    it { is_expected.to include(people[2]) }
  end

  context 'parse a empty file' do
    let(:file_path) { File.expand_path('../support/empty_file.txt', __FILE__) }

    it { expect(subject.length).to eq(0)   }
  end
end
