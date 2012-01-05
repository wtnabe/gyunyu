# -*- coding: utf-8 -*-
require 'optparse'

module Gyunyu
  module Command
    module Export
      class Option
        class FormatNotFound < StandardError; end
        class CustomFilterNotFound < StandardError; end

        FIELD_SEP = ','

        def initialize( argv = [] )
          @lists         = []
          @filter        = nil
          @custom_filter = nil
          @fields        = []
          @format        = :csv

          parser.parse( argv )
        end
        attr_reader :lists, :filter, :custom_filter, :fields, :format

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
            opt.on('-c', '--custom-filter FILTER') { |filter|
              mod = Module.nesting[1].const_get('CustomFilter')
              if mod.filter.has_key?( filter )
                @custom_filter = filter
              else
                raise CustomFilterNotFound
              end
            }
            opt.on('-d', '--field FIELD') { |field|
              if field.include?( FIELD_SEP )
                @fields = field.split( FIELD_SEP )
              elsif !@fields.include?( field )
                @fields << field
              end
            }
            opt.on('-o', '--format FORMAT') { |format|
              format.downcase!
              formats = Format.constants.map { |e|
                e.to_s.downcase
              }
              if formats.include?( format )
                @format = format
              else
                raise FormatNotFound
              end
            }
          end
        end
      end
    end
  end
end
