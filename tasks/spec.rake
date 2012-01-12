# -*- mode: ruby -*-

namespace :spec do
  Dir.glob( File.dirname(__FILE__) + '/../spec/*' ).select { |e|
    File.directory? e and File.basename( e ) != 'support'
  }.each { |d|
    RSpec::Core::RakeTask.new( File.basename( d ) ) { |spec|
      spec.pattern = "#{d}/**/*.rb"
    }
  }
end
