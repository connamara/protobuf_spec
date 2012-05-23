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
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "protobuf_spec"
  gem.homepage = "http://github.com/connamara/protobuf_spec"
  gem.license = "Connamara"
  gem.summary = %Q{RSpec matchers and cucumber step defs for testing protocol buffers}
  gem.description = %Q{Leverages json_spec to test structured protocol buffers with json data modeling}
  gem.email = "support@connamara.com"
  gem.authors = ["Chris Busbey"]
  # dependencies defined in Gemfile
end

require 'ci/reporter/rake/rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "protobuf_spec #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--color --format pretty --format junit --out features/reports}
end
