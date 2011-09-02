require 'yaml'

module RSSH
  module Action
    class Entry

      attr_accessor :host, :tag

      def initialize attrs = {}
        self.attributes = attrs
      end

      def connect
        puts "Connecting to #{self.host} at #{Time.now}"
        exec "ssh #{self.host}"
      end

      def attributes
        { :host => host, :tag => tag }
      end

      def entry=(host)
        @host = host
      end

      private

      def attributes=(attributes)
        return if attributes.empty?
        attributes.each do |k, v|
          respond_to?(:"#{k.to_s}=") ? send(:"#{k.to_s}=", v) : raise('Error', "unknown attribute: #{k}")
        end 
      end

    end
  end
end
