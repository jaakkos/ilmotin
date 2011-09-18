require 'spec_helper'

describe Ilmotin::Clients::Hipchat do
  
  let :response do
    double("response")
  end
  
  [404, 401, 500, 200].each do |resp_code|
    let :"response_#{resp_code}" do
      resp = response
      resp.stub(:code).return(resp_code)
      resp
    end    
  end

  
  subject do
    Ilmotin::Clients::Base.new("12345-12345", { from: "from", room_id: "room_id" } )
  end
  
  context "responses" do
    it "should raise error if response code 404" do
      lambda { subject.send(:check_response, response_404) }.should raise_error(::Ilmotin::Clients::UnknownRoom)
    end
    
    it "should raise error if response code 401" do
      lambda { subject.send(:check_response, response_401) }.should raise_error(::Ilmotin::Clients::Unauthorized)
    end
    
    it "should raise not error if response 200" do
      lambda { subject.send(:check_response, response_200) }.should_not raise_error
    end      
        
  end


end