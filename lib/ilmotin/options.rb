require 'optparse'
require 'ostruct'

module ::Ilmotin
  class Options
    APPLICATION_COMMANDS = %w(send)
    CLIENT_TYPES = %w(hipchat campfire)

    def self.parse(args)
      options = {}
      options[:client_type_name] = (ENV['CLIENT_TYPE'] || nil),
      options[:room_id] =  (ENV['ROOM_ID'] || nil)
      options[:auth_token] =  (ENV['AUTH_TOKEN'] || nil)
      options[:from] = (ENV['FROM'] || "Ilmotin")
      options[:notice_users] = (ENV['NOTICE_USERS'] || false)

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: ilmotin [options] message"
        
        opts.on("-c", "--client CLIENT_TYPE", String, "Client types [#{CLIENT_TYPES.join(' ,')}]") do |client_type_name|
          options[:client_type_name] = client_type_name
        end
  
        opts.on("-r", "--room ROOM_ID", String, "Room id") do |room_id|
          options[:room_id] = room_id
        end
  
        opts.on("-a", "--auth-token AUTH_TOKEN", String, "Authentication Token") do |auth_token|
          options[:auth_token] = auth_token
        end
  
        opts.on("-f", "--from FROM", String, "Announcer, default #{options[:from]} (only for hipchat)") do |from|
          options[:from] = from
        end
  
        opts.on("-n", "--notice-users 1||0", String, "Notice all users (only for hipchat)") do |notice|
          options[:notice_users] = notice
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
        end
  
  
        opts.on_tail('-h','--help', 'Show this message', &help)
  
        opts.on_tail('--test', 'Show settings') do 
          puts "Settings"
          puts
          puts "Room: \t\t#{options[:room_id]}"
          puts "Auth token: \t#{options[:auth_token]}"
          puts "From: \t\t#{options[:from]}"
          puts "Notice users: \t#{options[:notice_users]}"
          exit    
        end
  
        opts.on_tail('--version', 'Show version') do
          version = File.exist?('../VERSION') ? File.read('../VERSION') : ""
          puts "Ilmotin version: #{version}"
        end
  
        help.call if ARGV.empty?
      end

      opts.parse!(args)
      
      case options[:client_type_name]
      when "campfire"
        options[:client_type] = ::Ilmotin::Clients::Campfire 
      when "hipchat"
        options[:client_type] = ::Ilmotin::Clients::Hipchat
      else
        options[:client_type] = ::Ilmotin::Clients::Hipchat
      end

      
      unless options[:client_type].is_a? Class
        $stderr.puts "Invalid client type #{options[:client_type]}"
        exit(3)
      end
            
      if options[:auth_token].nil? || options[:room_id].nil?
        $stderr.puts "Auth token and room id missing"
        exit(3)        
      end
      
      options
    
    end # parse()
  
  end
end