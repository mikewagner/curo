require 'optparse'

module RSSH
  class Runner

    attr_accessor :options

    def initialize args
      @args    = args
      @actions = {}
    end

    def run
      @options = RSSH::Options.new @args

      raise "No action was specified" if options[:action].nil?

      action = find_action options[:action]
      action.invoke options
    end

    def find_action action
      begin
        action_name = action.capitalize
        RSSH::Action.const_get(action_name).new
      rescue
        puts "Invalid action #{action} \n\n"
        puts @options.parser
        exit 1
      end
    end

   
  
    
  end
end
