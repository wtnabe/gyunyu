# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../total_estimate'

if RUBY_VERSION < '1.9'
  require 'fastercsv'
else
  require 'csv'
  FasterCSV = CSV
end

module Gyunyu
  module Command
    module Export
      module Format
        module Csv
          @tags      = []
          @num_tags  = nil
          @num_notes = nil

          class << self
            include Export::TotalEstimate

            def export( tasks, fields )
              sum_estimate( tasks, fields )

              FasterCSV.generate { |csv|
                tasks, fields = parse( tasks, fields )
                csv << fields
                fields.delete('')
                tasks.each { |t|
                  csv << fields.map { |f|
                    case f
                    when 'tags'
                      t[f] = expand_tags( t[f] )
                    when 'notes'
                      num = instance_variable_get( "@num_#{f}" )
                      while t[f].size < num
                        t[f] += ['']
                      end
                    end
                    t[f]
                  }.flatten
                }

                if @total_estimate
                  csv << fields.map { |f|
                    @total_estimate.has_key?(f) ? @total_estimate[f] : ''
                  }
                end
              }
            end

            def parse( tasks, fields )
              if !fields.include?( 'tags' ) and !fields.include?( 'notes' )
                [tasks, fields]
              else
                if fields.include?( 'tags' )
                  tasks = tasks.map { |t| parse_tags( t ) }
                end
                if fields.include?( 'notes' )
                  tasks = tasks.map { |t| parse_notes( t ) }
                end

                [tasks, expand_fields( fields )]
              end
            end

            def parse_tags( t )
              tags = if t['tags'].first.has_key? 'tag'
                       t['tags'].first['tag']
                     else
                       []
                     end
              update_tags_field( tags )

              t['tags'] = tags.sort

              t
            end

            def parse_notes( t )
              notes = if t['notes'].first.has_key? 'note'
                        t['notes'].first['note'].map { |n|
                          n['content']
                        }
                      else
                        []
                      end
              if !@num_notes or notes.size > @num_notes
                @num_notes = notes.size
              end
              t['notes'] = notes

              t
            end

            def update_tags_field( tags )
              @tags = (@tags | tags).sort

              @num_tags = @tags.size
            end

            def expand_fields( fields )
              fields.map { |e|
                case e
                when 'tags', 'notes'
                  num = instance_variable_get("@num_#{e}")
                  if num and num > 1
                    [e] + Array.new(num - 1, '')
                  else
                    e
                  end
                else
                  e
                end
              }.flatten
            end

            def expand_tags( tags )
              @tags.map { |e|
                tags.include?(e) ? e : ''
              }
            end
          end
        end
      end
    end
  end
end

