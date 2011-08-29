module RSSH
  module Action
    class Add

      def initialize options = {}
        @options = {}
      end

      def invoke options = {}
        @options = options
        p @options
      end


    end
  end
end
