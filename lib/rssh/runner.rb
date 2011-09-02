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
      begin
        raise "No action was specified" if options[:action].nil?

        entry = find_entry options[:action]
        return entry.connect if entry

        action = find_action options.delete(:action)
        action.invoke options
      rescue Exception => e
        puts e.message
        exit
      end
    end


    private

    def find_entry action
      RSSH.config.find action
    end

    def find_action action
      begin
        action_name = action.capitalize
        RSSH::Action.const_get(action_name).new
      rescue
        raise "Sorry, unable to determine action for '#{action}'"
      end
    end
   
  end
end
