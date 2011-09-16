module RSSH
  module Action
    class Add

      def invoke options = {}
        begin
          entry   = RSSH::Action::Entry.new options
  
          raise "Tag already exists for '#{entry.tag}'"    if RSSH.config.has_tag? entry.tag
          raise "Entry already exists for '#{entry.host}'" if RSSH.config.has_host? entry.host

          RSSH.config << entry
          RSSH.config.save

          msg  = "Saved '#{entry.host}'"
          msg += " with tag " + "'#{entry.tag}'" if entry.has_tag?
          puts msg
        rescue Exception => e
          puts e.message
        end
      end

    end
  end
end
