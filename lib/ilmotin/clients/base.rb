require 'httparty'
require 'ostruct'

module ::Ilmotin
  module Clients
  
    class NotImplemented      < StandardError; end
    class UnknownRoom         < StandardError; end
    class Unauthorized        < StandardError; end
    class UnknownResponseCode < StandardError; end
  
    class Base < OpenStruct
      include HTTParty
    
      headers('Content-type' => 'application/json')
      format(:json)
    
      def initialize(token, options)
        @token = token
        super(options)
      end
    
      def deliver(message, notify = false)
        raise NotImplemented, 'send need to be implemented'
      end
    
      protected
    
      def check_response(response)
        case response.code
           when 200; # All ok
           when 404; raise UnknownRoom,  "Unknown room: '#{room_id}'"
           when 401; raise Unauthorized, "Access denied to room '#{room_id}'"
           else      raise UnknownResponseCode, "Unexpected #{response.code} for " <<
                                                "room '#{room_id}'"
          end      
      end
    
    end
  end
end