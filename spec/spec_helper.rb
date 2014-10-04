require_relative '../lib/logstash-test'

Logstash::Service.setup do |conf|
  conf.executable_path = File.expand_path('../resources/bin/logstash-1.3.3-flatjar.jar', File.dirname(__FILE__))
  conf.filters_path = File.expand_path('./fixtures/dummy-filters.conf', File.dirname(__FILE__))
end

RSpec.configure do |config|
  config.before(:suite) do
    Logstash::Service.start
  end
end
