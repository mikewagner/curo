require 'yaml'
require 'fileutils'

module RSSH
  class Configuration

    attr_accessor :path

    DEFAULT = File.expand_path('~/.rssh_config')

    class << self

      def load path = nil
        config = new path
        config.load!
        config
      end
    end

    def initialize path = nil
      @path = path || DEFAULT
    end

    def entries
      @entries ||= []
    end

    def << entry
      entries << entry
    end

    def has_tag? tag
      tags.include? tag    
    end

    def has_host? host
      hosts.include? host
    end

    def hosts
      @hosts ||= entries.collect(&:host).compact.uniq
    end

    def tags
      @tags ||= entries.collect(&:tag).compact.uniq
    end
 
    def find arg
      entries.detect { |e| e.host == arg || e.tag == arg } 
    end
  
    def load!
      FileUtils.touch @path unless File.exist? @path
      contents = YAML.load( File.read( @path ) ) || []
      contents.each do |entry|
        entries << RSSH::Action::Entry.new( entry )
      end
    end

    def save
      File.open( @path, 'w' ) do |file|
        file.write YAML.dump entries.collect { |e| e.attributes }
      end
   end

  end
end
