module RSSH
  module Action
    class List

      def invoke options = {}
        begin
          entries = RSSH.config.entries

          entries.each do |entry|
            puts entry.to_s
          end
        rescue Exception => e
          puts e.message
          exit
        end
      end


    end
  end
end
