module RSSH
  module Action
    class Add

      def initialize
      end

      def invoke options = {}
        @options = options
        entry   = RSSH::Action::Entry.new options
        entry.save
      end

    end
  end
end
