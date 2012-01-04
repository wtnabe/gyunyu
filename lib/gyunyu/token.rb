require 'fileutils'

module Gyunyu
  class Token
    API_KEY       = '0af285d87a0798cdd4751acfb02fc058'
    SHARED_SECRET = 'f0611feb04a04e1d'

    include ::FileUtils

    def initialize
      RTM::API.init( API_KEY, SHARED_SECRET )
    end

    def self.get
      @self = self.new
      token = @self.load

      if ( !token )
        token = @self.request
        @self.save( token )
      end

      RTM::API.token = token
      token
    end

    def self.purge
      RTM::API.token = nil
      self.new.instance_eval {
        while ( File.exist?( magazine ) )
          rm( magazine )
        end
      }
    end

    def save( token )
      if ( !File.exist?( magazine ) )
        open( magazine, 'w', 0600 ) { }
      end

      open( magazine, 'r+b', 0600 ) { |f|
        f.flock( File::LOCK_EX )
        f.truncate(0)
        f.print token
        f.flock( File::LOCK_UN )
      }
      token
    end

    def load
      token = nil

      if ( File.exist?( magazine ) )
        open( magazine, 'r+b' ) { |f|
          # TODO WARN if permission is too loose
          f.flock( File::LOCK_SH )
          token = f.read
          f.flock( File::LOCK_UN )
        }
      end

      token
    end

    def magazine
      env || dotfile
    end

    def env
      ENV['RTMSTAT_TOKEN']
    end

    def dotfile
      File.join( ENV['HOME'], '.gyunyu' )
    end

    def request
      frob = RTM::Auth::GetFrob.new.invoke
      url  = RTM::API.get_auth_url('read', frob)
      puts "open RTM with browser and accept API KEY."
      puts "and hit enter."
      system("open '#{url}'")
      STDIN.gets

      res = RTM::Auth::GetToken.new(frob).invoke
      res[:token]
    end
  end
end
