# -*- coding: utf-8 -*-
require 'json'

module Gyunyu
  module Command
    module Export
      module Format
        module Json
          def self.export( tasks, fields )
            tasks.to_json
          end
        end
      end
    end
  end
end
