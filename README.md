logstash-test
=============

Gem to test logstash filters.

USAGE
=====

Include the gem in your Gemfile:

```ruby
group :test do
  gem 'logstash-test', '~>0.1'
end
```

Configure the logstash-test in your spec\_helper file:

```ruby
Logstash::Service.setup do |config|
  config.executable_path = '/full/path/to/your/logstash.jar'
  config.filters_path = '/full/path/to/your/filters.conf'

  # Optional
  config.output_port = 12000
  config.input_port = 12001
end

RSpec.configure do |config|
  config.before(:suite) do
    Logstash::Service.start
  end
end
```

In your spec file, you can now use:

```ruby
describe 'Logstash filters' do
  let(:message) { 'test' }

  it 'passes our grok filter' do
    expect(Logstash::Service.query(message)['tags']).to include('grok_success')
  end
end
```
