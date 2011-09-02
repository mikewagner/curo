require 'yaml'

module RSSH
  module Action
    class Entry

      attr_accessor :entry, :tag

      def initialize attrs = {}
        self.attributes = attrs
      end

      def connect
        puts "Connecting to #{self.entry} at #{Time.now}"
        exec "ssh #{self.entry}"
      end

      def save
       RSSH.config << self
       RSSH.config.save
       puts "Saved #{self.entry} #{'with tag ' + self.tag if self.tag}"
      end

      def attributes
        { :entry => entry, :tag => tag }
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
