require 'optparse'

module Gyunyu
  module Command
    module Export
      class Option
        def initialize( argv = [] )
          @lists  = []
          @filter = nil

          parser.parse( argv )
        end
        attr_reader :lists, :filter

        def parser
          OptionParser.new do |opt|
            opt.on('-l', '--list LIST') { |list|
              if !@lists.include?( list )
                @lists << list
              end
            }
            opt.on('-f', '--filter FILTER') { |filter|
              @filter = filter if filter.size > 0
            }
          end
        end
      end
    end
  end
end
