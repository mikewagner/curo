module RSSH
  module Action
    class Remove

      def invoke options = {}
        begin
          RSSH.config.remove options[:entry]
          RSSH.config.save
          puts "Removed entry for '#{options[:entry]}'"
        rescue Exception => e
          puts e.message
          exit
        end
      end


    end
  end
end
