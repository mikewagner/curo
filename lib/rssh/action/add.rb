module RSSH
  module Action
    class Add

      def initialize
      end

      def invoke options = {}
        @options = options
        entry   = RSSH::Action::Entry.new options
  
        raise "Tag already exists"   if RSSH.config.has_tag? entry.tag
        raise "Entry already exists" if RSSH.config.has_host? entry.host

        RSSH.config << entry
        RSSH.config.save
        puts "Saved #{entry.host} #{'with tag ' + entry.tag if entry.tag}"
      end


    end
  end
end
