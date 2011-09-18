module ::Ilmotin
  class Pill < ::Bluepill::Trigger
    PARAMS = [:times, :within, :retry_in, :api_token, :room_id, :from, :notify_users]
    attr_accessor *PARAMS 
  
    def initialize(process, options = {})
      options.reverse_merge!(:times => 5, :within => 1, :retry_in => 5)

      options.each_pair do |name, val|
        instance_variable_set("@#{name}", val) if PARAMS.include?(name)
      end
    
      super
    end
  
    def notify(transition)
      begin
        unless transition.to == transition.from
          send_message("Your process #{process.name} went from #{transition.from_name} to #{transition.to_name} at #{Time.now}", @notify_users)
        end
      rescue => exception
        puts "Exception while trying to send message: #{exception.message}"
      end
    end
  
    private
  
    def send_message(message, notify_users = false)
       hipchat_client.send(message, notify_users)
    end
  
    def hipchat_client
      @hc_client ||= Ilmotin::Clients::Hipchat.new(@api_token, room_id: @room_id, from: @from)
    end
  
  end
end