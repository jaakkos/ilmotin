module Ilmotin::Clients
  class Hipchat < Ilmotin::Clients::Base
   
    headers('Content-type' => 'application/x-www-form-urlencoded')
    base_uri('https://api.hipchat.com/v1/rooms')
   
    def deliver(message, notify_users = false)
      response = self.class.post('/message',
        query: { auth_token: @token, format: "json" },
        body:  parse_body(message, notify_users))
      check_response(response)
    end
    
    private
    
    def parse_body(message, notify_users = false)
      { room_id: room_id.to_i, from: from, message: message, notify: notify_users ? 1 : 0 }
    end
       
  end
end