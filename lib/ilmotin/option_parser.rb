require 'optparse'
require 'ostruct'

module ::Ilmotin
  class OptionParser
    APPLICATION_COMMANDS = %w(send)
    CLIENT_TYPES = %w(hipchat campfire)

    def self.parse(args)
      options = OpenStruct.new
      options.client_type = (ENV['CLIENT_TYPE'] || 'hipchat')
      options.room_id =  (ENV['ROOM_ID'] || "12345")
      options.auth_token =  (ENV['AUTH_TOKEN'] || "qwerty123456")
      options.from = (ENV['FROM'] || "HibChatNotifier")
      options.notice_users = (ENV['AUTH_NOTICE_USERS'] || false)

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: chat-notify [options] message"
  
        opts.on("-c", "--client CLIENT_TYPE", String, "Client types [#{CLIENT_TYPES.join(' ,')}]") do |client_type|
          options.client_type = client_type
        end
  
        opts.on("-r", "--room ROOM_ID", String, "Room id") do |room_id|
          options.room_id = room_id
        end
  
        opts.on("-a", "--auth-token AUTH_TOKEN", String, "Authentication Token") do |auth_token|
          options.auth_token = auth_token
        end
  
        opts.on("-f", "--from FROM", String, "Announcer, default #{options.from} (only for hipchat)") do |from|
          options.from = from
        end
  
        opts.on("-n", "--notice-users TRUE||FALSE", String, "Notice all users (only for hipchat)") do |notice|
          options.notice_users = notice
        end
  
        help = proc do
          puts opts
          puts 
          puts "Environment variables:"
          puts "    CLIENT_TYPE \t\tClient type"
          puts "    ROOM_ID \t\t\tRoom id"
          puts "    AUTH_TOKEN\t\t\tHipchat auth token"
          puts "    FROM\t\t\tSet message's from. (just for hipchat)"
          puts "    NOTICE_USERS\t\tNotify all users in the room. (just for hipchat)"
          puts 
          puts "Commands:"
          puts "    send [Message] \t\tSend message to room"
          puts 
        end
  
  
        opts.on_tail('-h','--help', 'Show this message', &help)
  
        opts.on_tail('--test', 'Show settings') do 
          puts "Settings"
          puts
          puts "Client type: \t#{options.client_type}"
          puts "Room: \t\t#{options.room_id}"
          puts "Auth token: \t#{options.auth_token}"
          puts "From: \t\t#{options.from}"
          puts "Notice users: \t#{options.notice_users}"
          puts "Message: \t\t #{options.message}"
          exit    
        end
  
        opts.on_tail('--version', 'Show version') do
          version = File.exist?('../VERSION') ? File.read('../VERSION') : ""
          puts "Chat Notify version: #{version}"
        end
  
        help.call if ARGV.empty?
      end
    
      opts.parse!(args)
      unless CLIENT_TYPES.include?(options.client_type)
        $stderr.puts "Invalid client type #{options.client_type}"
        exit(3)
      end
      options
    
    end # parse()
  
  end
end