module Gyunyu
  module Command
    class NotFound < StandardError; end

    def self.commands
      constants.map { |e| e.to_s.downcase }
    end

    def self.dispatch( command )
      if commands.include?( command )
        app_const( command ).new.run
      else
        raise NotFound, command
      end
    end

    def self.app_const( command )
      Gyunyu::Command.const_get(command.capitalize).const_get('App')
    end
  end
end
