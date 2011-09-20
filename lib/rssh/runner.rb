module RSSH
  class Runner

    attr_accessor :options

    def initialize args
      @args    = args
      @options = RSSH::Options.new @args
    end

    def run
      begin
        raise "No action was specified" if options[:action].nil?

        @config = RSSH::Configuration.load
        action = @options.delete(:action)

        entry = @config.find action
        if entry
          RSSH::Connection.new( entry, options ).connect
        else
          if respond_to?(:"#{action}") 
            send(:"#{action}") 
          else
            raise('Error', "unknown attribute: #{k}")
          end
        end
      rescue Exception => e
        puts e.message
        exit
      end
    end

    def add 
      entry = RSSH::Entry.new @options

      raise "Tag already exists for '#{entry.tag}'"    if @config.has_tag?  entry.tag
      raise "Entry already exists for '#{entry.host}'" if @config.has_host? entry.host

      @config << entry
      @config.save

      msg  = "Saved '#{entry.host}'"
      msg += " with tag " + "'#{entry.tag}'" if entry.has_tag?
      puts msg
    end


    def remove 
      entry_name_or_tag = options[:entry]
      @config.remove entry_name_or_tag 
      puts "Removed entry for '#{entry_name_or_tag}'"
    end


    def list
      entries = @config.entries
      entries.each do |entry|
        puts entry.to_s
      end
    end

  end
end
