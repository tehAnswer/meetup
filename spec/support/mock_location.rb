RSpec.shared_context 'mocked location' do
  before do
    Dependencies.stub(:lat_origin, 53.339428)
    Dependencies.stub(:lon_origin, -6.257664)
  end

  after do
    Dependencies.unstub(:lat_origin)
    Dependencies.unstub(:lon_origin)
  end
end
