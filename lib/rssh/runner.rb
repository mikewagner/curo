module RSSH
  class Runner

    attr_accessor :options

    class << self

      def run args
        runner = new args
        runner.run
      end
  
    end

    def initialize args
      @args    = args
      @options = RSSH::Options.new @args
    end

    def run
      raise "No action was specified" if options[:action].nil?
      action = find_action options.delete(:action)
      action.invoke options
    end


    private


    def find_action action
      begin
        action_name = action.capitalize
        RSSH::Action.const_get(action_name).new
      rescue
        raise "Invalid action #{action}"
      end
    end
   
  end
end
