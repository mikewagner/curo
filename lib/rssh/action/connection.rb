module RSSH
  module Action
    class Connection

      def initialize entry, options = {}
        @entry   = entry
        @options = options
      end

      def connect 
        puts connect_message
        command  = ["ssh ", [self.connecting_as, @entry.host].join('@')].join(' ')
        exec command
      end

      def connecting_as
        if @options[:user]
          @options[:user]
        else
          if @entry.has_user? 
            @entry.user 
          else
             ENV['USER']
          end
        end
      end

      private

      def connect_message
        ["Connecting to", @entry.host, "as", self.connecting_as, "at", Time.now].join(' ')
      end

    end
  end
end
