require 'fileutils'
require 'open-uri'

desc 'Prepare environment'
task :prepare do
  logstash_jar_url = 'https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar'
  resources_path = File.expand_path('./resources/bin/', File.dirname(__FILE__))

  puts '-- Creating resources folder'
  FileUtils.mkdir_p(resources_path)

  puts '-- Downloading LogStash'
  if File.exists?(resources_path + '/logstash-1.3.3-flatjar.jar')
    puts '    * File already exists. No action taken.'
  else
    File.open(resources_path + '/logstash-1.3.3-flatjar.jar', 'wb') do |file|
      file << open(logstash_jar_url).read
    end
  end
end
