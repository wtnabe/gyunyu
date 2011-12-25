require 'rtmilk'

module Gyunyu
end

Dir.glob(File.dirname(__FILE__) + '/gyunyu/**/*.rb').each { |f|
  require f.sub( /\.rb\z/, '' )
}
