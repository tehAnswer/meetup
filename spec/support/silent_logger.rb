RSpec.shared_context 'silent logger' do
  before do
    logger = double(error: 'OK', warn: 'OK')
    Dependencies.stub(:logger, logger)
  end
  after  { Dependencies.unstub(:logger) }
end
