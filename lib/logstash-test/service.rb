require 'socket'
require 'fileutils'
require 'json'

module Logstash
  class Service
    def self.setup
      @@config = Config.new.tap do |config|
        yield(config) if block_given?
      end
    end

    def self.start
      child_pid = fork do
        STDERR.reopen("/dev/null")
        STDOUT.reopen("/dev/null")

        exec("java -jar #{@@config.executable_path} agent -e \"#{@@config.debug_filters} $(cat #{@@config.filters_path})\"")
      end

      at_exit { Process.kill("TERM", child_pid) }

      wait_for_logstash
    end

    def self.wait_for_logstash
      retry_count = 0

      begin
        input_socket = TCPSocket.new('localhost', @@config.input_port)
        input_socket.close

        output_socket = TCPSocket.new('localhost', @@config.output_port)
        output_socket.close
      rescue Errno::ECONNREFUSED => e
        sleep 1
        retry_count += 1
        retry if retry_count < 30

        raise e
      end
    end

    def self.query(message)
      input_socket = TCPSocket.new('localhost', @@config.input_port)
      input_socket.write(message + "\n")
      input_socket.close

      output_socket = TCPSocket.new('localhost', @@config.output_port)
      response = output_socket.gets
      output_socket.close

      JSON.parse(response)
    end
  end
end
