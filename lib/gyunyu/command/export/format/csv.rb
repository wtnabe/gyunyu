# -*- coding: utf-8 -*-
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
          def self.export( tasks, fields )
            FasterCSV.generate { |csv|
              csv << fields
              tasks.each { |t|
                csv << fields.map { |f| t[f] }
              }
            }
          end
        end
      end
    end
  end
end

