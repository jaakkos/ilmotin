require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'timecop'

require File.expand_path(File.dirname(__FILE__) + '/../lib/ilmotin.rb')


RSpec.configure do |config|
  config.mock_with :rspec
end

