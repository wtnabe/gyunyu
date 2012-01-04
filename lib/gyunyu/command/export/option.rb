require 'optparse'

module Gyunyu
  module Command
    module Export
      class Option
        FIELD_SEP = ','

        def initialize( argv = [] )
          @lists  = []
          @filter = nil
          @fields = []

          parser.parse( argv )
        end
        attr_reader :lists, :filter, :fields

        def fields
          if @fields.size > 0
            @fields
          else
            %w( task_id name due )
          end
        end

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
            opt.on('-d', '--field FIELD') { |field|
              if field.include?( FIELD_SEP )
                @fields = field.split( FIELD_SEP )
              elsif !@fields.include?( field )
                @fields << field
              end
            }
          end
        end
      end
    end
  end
end
