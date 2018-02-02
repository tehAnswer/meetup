RSpec.describe 'Meetup' do
  include_context 'silent logger'
  include_context 'mocked location'

  before do
    Dependencies.stub(:file_path, File.expand_path('../support/file_users.txt', __FILE__))
  end
  after { Dependencies.unstub(:file_path) }

  # Sadly, Terminal::Table gem has not implemented  == operator. I am sending a PR to add
  # such method, but in the meantime, string comparasion will do it.
  let(:expected_table) do
    Terminal::Table.new(title: 'Invited Customers', headings: %w(ID Name), rows: rows).to_s
  end

  context 'without a custom path' do
    subject { Meetup.attendees_in(100).to_s }
    let(:rows) do
      [
        [0, 'Foo'],
        [3, 'Foo']
      ]
    end
    it { is_expected.to eq(expected_table) }
  end

  context 'with custom path' do
    subject { Meetup.attendees_in(100, file_path).to_s }
    let(:file_path) { File.expand_path('../support/empty_file.txt', __FILE__) }
    let(:rows) { [] }

    it { is_expected.to eq(expected_table) }
  end
end
