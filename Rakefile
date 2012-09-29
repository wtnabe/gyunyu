# -*- mode: ruby; encoding: utf-8 -*-

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "gyunyu"
  gem.homepage = "http://github.com/wtnabe/gyunyu"
  gem.license = "MIT"
  gem.summary = %Q{Simple RTM app for CLI}
  gem.description = %Q{now available export command}
  gem.email = "wtnabe@gmail.com"
  gem.authors = ["wtnabe"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  desc 'Run Rspec & Create Coverage'
  RSpec::Core::RakeTask.new(:coverage) do
    ENV['COVERAGE'] = "true"
  end
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

Dir.glob('tasks/**/*.rake') { |f|
  load File.join(File.dirname(__FILE__), f)
}
