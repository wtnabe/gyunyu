# -*- coding: utf-8 -*-

module Gyunyu
  module Command
    module Export
      class App
        TIME_FIELDS = %w( created modified due added completed deleted )

        def initialize
          @argv  ||= ARGV
          @token ||= Gyunyu::Token.get
          @lists ||= RTM::List.alive_all

          _init_option( @argv )
        end
        attr_reader :option, :token, :lists

        #
        # [return] Array
        #
        def fields
          ['list'] + option.fields.map { |f|
            if f == 'estimate'
              %w( estimate(d) estimate(h) estimate(m) )
            else
              f
            end
          }.flatten
        end

        #
        # [return] Module
        #
        def format_module
          format = option.format.to_s.capitalize
          Format.const_get(format)
        end

        #
        # [param] Array argv
        # [return] Option
        #
        def _init_option( argv = nil )
          @option = Option.new( argv )
        end

        def run
          if @argv.size > 0
            if option.show_filter_list
              puts CustomFilter.filter.keys.sort
            else
              export( build_filter )
            end
          else
            puts option.parser
          end
        end

        #
        # [param] String filter
        # [return] String
        #
        def build_filter( filter = nil )
          filters = []

          filters << option.lists.map { |l| "list:#{l}" }.join(' or ') if option.lists.size > 0
          filters << CustomFilter.filter[option.custom_filter] if option.custom_filter
          filters << option.filter if option.filter
          filters << filter if filter

          f = '(' + filters.join(') and (') + ')'
          STDERR.puts f
          f
        end

        #
        # [param] String filter
        # [return] RTM::Tasks::GetList
        #
        def task_list( filter = nil )
          RTM::Tasks::GetList.new( token,
                                   nil,
                                   filter ).invoke
        end

        #
        # [param] String id
        # [return] RTM::List
        #
        def find_list( id )
          @lists.find { |list|
            list.id == id
          }
        end

        #
        # [param] String filter
        # [return] Array
        #
        def pickup_fields( filter = nil )
          tasks = []

          result = task_list( filter )
          if result.respond_to? :each
            result.each { |l|
              list_name = find_list( l['id'] ).name
              tasks += Gyunyu::Expander.taskseries( l['taskseries'] ).map { |t|
                record = {'list' => list_name}
                option.fields.each { |f|
                  val = if TIME_FIELDS.include?( f )
                          localtime( t[f] )
                        else
                          t[f]
                        end
                  if f == 'estimate'
                    e = split_estimate( t[f] )
                    record['estimate(d)'] = e.day
                    record['estimate(h)'] = e.hour
                    record['estimate(m)'] = e.min
                  else
                    record[f] = val
                  end
                }
                record
              }
            }
          end

          tasks
        end

        #
        # [param] String filter
        # [return] Object
        #
        def export( filter = nil )
          puts format_module.export( pickup_fields( filter ), fields )
        end

        #
        # [param]  String estimate
        # [return] RtmTime
        #
        def split_estimate( estimate )
          ::RtmTime::Ja.parse(estimate)
        end

        #
        # [param]  String
        # [return] Time
        #
        def localtime( time )
          if time.size > 0
            Time.parse( time ).localtime
          else
            time
          end
        end
      end
    end
  end
end
