module RSSH
  module Action
    class Entry

      attr_accessor :host, :tag, :user

      def initialize attrs = {}, &block
        self.attributes = attrs
        yield(self) if block_given?
      end

      def connect 
        puts connect_message
        command  = ["ssh ", [self.connecting_as, self.host].join('@')].join(' ')
        exec command
      end

      def attributes
        attrs = {}
        attrs[:host] = self.host
        attrs[:tag]  = self.tag  if self.has_tag?
        attrs[:user] = self.user if self.has_user?
        attrs
      end

      def to_s
        string = []
        string << self.host
        string << "<#{self.user}>" if self.has_user?
        string << "(#{self.tag})"  if self.has_tag?
        string.join(' ')
      end

      def entry=(host)
        @host = host
      end

      def connecting_as
        self.has_user? ? self.user : ENV['USER']
      end

      def has_tag?
        return false if self.tag.nil? || self.tag.empty?
        true
      end

      def has_user?
        return false if self.user.nil? || self.user.empty?
        true
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
