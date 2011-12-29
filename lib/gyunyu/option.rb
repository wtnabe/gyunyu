require 'optparse'

module Gyunyu
  class Option
    def initialize( argv = [] )
      @lists = []

      parser.parse( argv )
    end
    attr_reader :lists

    def parser
      OptionParser.new do |opt|
        opt.on('-l', '--list LIST') { |list|
          if !@lists.include?( list )
            @lists << list
          end
        }
      end
    end
  end
end
