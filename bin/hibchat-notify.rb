#!/usr/bin/env ruby

require 'optparser'

begin 
  require 'rbconfig'
rescue LoadError
end

RbConfig = Config unless Object.const_defined?(:RbConfig)

# Default options
options = {
  :room_id => "12345",
  :auth_token => "qwerty123456",
  :from => "HibChatNotifier"
}

OptionParser.new do |opts|
  opts.banner = "Usage: hibchat-notify [options] message"
  
  opts.on("-r", "--room ROOM_ID", "HipChat room id") do |room_id|
    options[:room_id] = room_id
  end
  
  opts.on("-a", "--auth-token AUTH_TOKEN", "HipChat Authentication Token") do |auth_token|
    options[:auth_token] = auth_token
  end
  
  opts.on("-f", "--from FROM", "Announcer, defaults to #{options[:from]}") do |from|
    options[:from]
  end
  
end
