$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'calculation_timeframe'
require 'rspec'
require 'rspec/autorun'
require 'timecop'

RSpec.configure do |config|

end
