require 'yaml'

module RSSH
  module Action
    class Entry

      ATTRIBUTES = %w(host tag user)
      attr_accessor *ATTRIBUTES

      def initialize attrs = {}, &block
        self.attributes = attrs
        yield(self) if block_given?
      end

      def connect
        puts connect_message
        command  = "ssh "
        command += self.user + '@' unless self.user.nil? || self.user.empty?
        command += self.host
        exec command
      end

      def attributes
        Hash.new.tap do |attr|
          ATTRIBUTES.each do |key|
            attr[key.to_sym] = instance_variable_get(:"@#{key}")
          end 
        end
      end

      def to_s
        string  = "#{self.host}"
        string += " (#{self.tag})" unless self.tag.nil? || self.tag.empty?
        string
      end

      def entry=(host)
        @host = host
      end

      def connecting_as
        (self.user.nil? || self.user.empty?) ? ENV['USER'] : self.user
      end

      private

      def connect_message
        ["Connecting to", self.host, "as", self.connecting_as, "at", Time.now].join(' ')
      end

      def attributes=(attributes)
        return if attributes.empty?
        attributes.each do |k, v|
          respond_to?(:"#{k.to_s}=") ? send(:"#{k.to_s}=", v) : raise('Error', "unknown attribute: #{k}")
        end 
      end

    end
  end
end
