require 'spec_helper'

describe Ilmotin::Clients::Hipchat do
  
  let :response do
    double("response")
  end
  
  let :"404" do
    resp = response
    resp.stub(:status).return("404")
    resp
  end
  
  subject do
    Ilmotin::Clients::Hipchat.new("12345-12345", { from: "from", room_id: "room_id" } )
  end
  
  it "should notify parse correct body for post" do
    subject.send(:parse_body, "Hello World").should == 
      { from: "from", room_id: "room_id", message: "Hello World", notify: 0 }
  end
  
  %w(from room_id).each do |variable|
    it "should initialize #{variable}" do
     subject.respond_to?(variable.to_sym).should == true
     subject.send(variable.to_sym).should == variable 
    end
  end

end