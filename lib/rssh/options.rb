require 'optparse'

module RSSH
  class Options < Hash
    
    attr_reader :parser

    def initialize args
      super()

      @parser = OptionParser.new do |opts|
        opts.on('-t', '--tag [TAG]', String, 'Specify the tag name to association to host') do |tag|
          self[:tag] = tag
        end

        opts.on_tail('-h', '--help', 'Display help' ) do
          puts parser
          exit 
        end
      end

      begin
        @parser.parse! args
        action_options = @parser.permute(args)
        self[:action]  = action_options.shift
        self[:entry]   = action_options.shift
      rescue OptionParser::InvalidOption => e
        puts e.message
        puts @parser
        exit 1
      end
    end


  end
end
