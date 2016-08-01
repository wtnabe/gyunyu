$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'

RSpec.configure do |config|
  config.expect_with(:rspec) do |c|
    c.syntax    = :should
  end

  config.mock_with :rr

  config.after do
    RR.reset
  end
end

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'gyunyu'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
