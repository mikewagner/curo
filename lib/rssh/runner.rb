module RSSH

  class InvalidAction < StandardError; end
  class DuplicateTag < StandardError; end
  class DuplicateHost < StandardError; end

  class Runner

    attr_accessor :action, :config

    def initialize config = nil
      @config = config || RSSH::Configuration.load
    end

    def run options
      begin
        action   = options.delete(:action)
        options  = options

        raise "No action was specified" if action.nil?

        entry = config.find action
        
        if entry
          RSSH::Connection.new( entry, options ).connect
        else
          case action
            when 'add'    then self.add RSSH::Entry.new(options)
            when 'list'   then self.list
            when 'remove' then self.remove options[:entry]
            else raise InvalidAction
          end    
        end
      rescue Exception => e
        puts e.message
        exit
      end
    end

    def add entry

      if @config.has_tag?(entry.tag)
        raise DuplicateTag, "Tag already exists for '#{entry.tag}'"
      end
      if @config.has_host?(entry.host)
        raise DuplicateHost, "Host already exists for '#{entry.host}'"
      end

      @config << entry
      @config.save

      msg  = "Saved '#{entry.host}'"
      msg += " with tag " + "'#{entry.tag}'" if entry.has_tag?
      puts msg
    end


    def remove entry_name_or_tag
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
