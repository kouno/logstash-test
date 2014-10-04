module Logstash
  class Config
    attr_accessor \
      :executable_path,
      :filters_path,
      :debug_filters,
      :child_process_id,
      :input_port,
      :output_port

    def debug_filters
      @debug_filters ||= <<-EOL
        input {
          tcp {
            host => 'localhost'
            port => #{input_port}
          }
        }

        output {
          tcp {
            mode => 'server'
            codec => json_lines
            host => 'localhost'
            port => #{output_port}
          }
        }
      EOL
    end

    def output_port
      @output_port ||= input_port + 1
    end

    def input_port
      @input_port ||= 12_000
    end
  end
end
