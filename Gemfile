# -*- mode: ruby -*-

source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.

gem 'rtmilk', '~> 0.3'
gem 'xml-simple'
gem 'rtm-time', '>= 0.3.0'
if RUBY_VERSION < '1.9'
  gem 'fastercsv'
  gem 'json'
end
if RUBY_VERSION > '2.2'
  gem 'test-unit'
end

group :development do
  gem "rspec", "> 2"
  gem "bundler"
  gem "jeweler"
  gem "yard"
  gem "simplecov"
  gem 'rr'
end
