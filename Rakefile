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
  gem.name = "bluepill-hipchat-notifier"
  gem.homepage = "http://github.com/jaakkos/bluepill-hipchat-notifier"
  gem.license = "MIT"
  gem.summary = %Q{Simple notice tool for sending status changes to HipCat}
  gem.description = %Q{Simple notice tool for sending status changes to HipCat}
  gem.email = "jaakko@suutarla.com"
  gem.authors = ["Jaakko Suutarla"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bluepill-hipchat-notifier #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
