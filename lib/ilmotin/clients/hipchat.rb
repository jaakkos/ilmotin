module Ilmotin::Clients
  class Hipchat < Ilmotin::Clients::Base
   
    base_uri 'https://api.hipchat.com/v1/rooms'
   
    def deliver(message, notify = false)
      response = self.class.post('/message',
        query: { auth_token: @token },
        body:  parse_body(message))
      check_response(response)
    end
    
    private
    
    def parse_body(message)
      { room_id: self.room_id, from: self.from, message: message, notify: notify ? 1 : 0 }
    end
       
  end
end