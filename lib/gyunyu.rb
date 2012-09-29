require 'rtmilk'
require 'rtm-time'

Version = open(File.dirname(__FILE__) + '/../VERSION').read

module Gyunyu
end

Dir.glob(File.dirname(__FILE__) + '/gyunyu/**/*.rb').each { |f|
  require f.sub( /\.rb\z/, '' )
}
