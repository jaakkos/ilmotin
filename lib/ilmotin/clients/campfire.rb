module Ilmotin::Clients
  class Campfire < Ilmotin::Clients::Base
   
    base_uri 'http://#{subdomain}.campfirenow.com'
   
    def deliver(message, notify = false)
      basic_auth @token, 'x'
      response = post("/room/#{room_id}/speak.json",
        body:  { body: { message: message, type: 'Textmessage' } } )
      
      check_response(response)
    end
       
  end
end