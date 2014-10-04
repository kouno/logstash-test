require 'spec_helper'

describe Logstash do
  let(:message) { '[production] [sinatra] -- test message' }
  let(:result) { Logstash::Service.query(message) }

  it 'parses the message properly' do
    {
      'environment' => 'production',
      'logfile'     => 'sinatra',
      'message'     => message,
      'tags'        => ['grok_success']
    }.each do |k, value|
      expect(result[k]).to eq(value)
    end
  end
end
