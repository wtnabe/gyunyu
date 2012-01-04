# -*- coding: utf-8 -*-
require 'yaml'

module Gyunyu
  module Command
    module Export
      module Format
        module Yaml
          def self.export( tasks, fields )
            tasks.to_yaml
          end
        end
      end
    end
  end
end
