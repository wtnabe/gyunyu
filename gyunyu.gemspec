# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gyunyu}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{wtnabe}]
  s.date = %q{2012-01-04}
  s.description = %q{now available export command}
  s.email = %q{wtnabe@gmail.com}
  s.executables = [%q{gyunyu}]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/gyunyu",
    "gyunyu.gemspec",
    "lib/gyunyu.rb",
    "lib/gyunyu/app.rb",
    "lib/gyunyu/command.rb",
    "lib/gyunyu/command/export/app.rb",
    "lib/gyunyu/command/export/format/csv.rb",
    "lib/gyunyu/command/export/format/json.rb",
    "lib/gyunyu/command/export/format/yaml.rb",
    "lib/gyunyu/command/export/option.rb",
    "lib/gyunyu/expander.rb",
    "lib/gyunyu/token.rb",
    "spec/app/.gitkeep",
    "spec/app/command/export/option_spec.rb",
    "spec/app/command_spec.rb",
    "spec/app/expander_spec.rb",
    "spec/spec_helper.rb",
    "spec/token/token_spec.rb",
    "tasks/git.rake",
    "tasks/spec.rake",
    "tmp/.gitkeep"
  ]
  s.homepage = %q{http://github.com/wtnabe/gyunyu}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Simple RTM app for CLI}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rtmilk>, [">= 0"])
      s.add_runtime_dependency(%q<xml-simple>, [">= 0"])
      s.add_runtime_dependency(%q<rtm-time>, [">= 0.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
    else
      s.add_dependency(%q<rtmilk>, [">= 0"])
      s.add_dependency(%q<xml-simple>, [">= 0"])
      s.add_dependency(%q<rtm-time>, [">= 0.2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
    end
  else
    s.add_dependency(%q<rtmilk>, [">= 0"])
    s.add_dependency(%q<xml-simple>, [">= 0"])
    s.add_dependency(%q<rtm-time>, [">= 0.2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
  end
end

