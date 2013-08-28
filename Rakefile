# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:cucumber)

task :test => [:spec, :cucumber]
task :default => :test

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "protobuf_spec"
  gem.homepage = "http://github.com/connamara/protobuf_spec"
  gem.license = "GPL"
  gem.summary = %Q{RSpec matchers and cucumber step defs for testing protocol buffers}
  gem.description = %Q{Leverages json_spec to test structured protocol buffers with json data modeling}
  gem.email = "info@connamara.com"
  gem.authors = ["Chris Busbey"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
