require 'spec_helper'

describe BluepillHipChatNotifier do
  
  before(:each) do
    new_time = Time.local(2008, 9, 1, 12, 0, 0)
    Timecop.freeze(new_time)
  end
  
  let(:hipchatclient) do
    hipchat = mock('HipChatClient')
  end
  
  let(:no_change_transition) do
    trans = double('transition')
    trans.stub(:to) { "state_one" }
    trans.stub(:from) { "state_one" }
    trans.stub(:to_name) { "state one" }
    trans.stub(:from_name) { "state one" }
    trans
  end
  
  let(:change_transition) do
    trans = double('transition')
    trans.stub(:to) { "state_one" }
    trans.stub(:from) { "state_two" }
    trans.stub(:to_name) { "state two" }
    trans.stub(:from_name) { "state one" }  
    trans
  end  
    
  let(:fake_process) do
    fake_p = double('process')
    fake_p.stub(:name) { 'fake process' }
    fake_p
  end  
  
  let(:default_message_with_transition) do
    "Your process fake process went from state one to state two at #{Time.now}"
  end
  
  let(:default_message_without_transition) do
    "Your process fake process went from state one to state one at #{Time.now}"
  end
    
  describe "settings" do
    it "should send notify users" do
      blue_notifier = BluepillHipChatNotifier.new(fake_process, :api_token => "sample", :room_id => 12345, :from => "Bluepill - sample", :notify_users => true)
      blue_notifier.stub(:hipchat_client) { hipchatclient }
      blue_notifier.should_receive(:send_message).with(default_message_with_transition, true)
      blue_notifier.notify(change_transition)
    end
    
    it "should not notify users" do
      blue_notifier = BluepillHipChatNotifier.new(fake_process, :api_token => "sample", :room_id => 12345, :from => "Bluepill - sample", :notify_users => false)
      blue_notifier.stub(:hipchat_client) { hipchatclient }
      blue_notifier.should_receive(:send_message).with(default_message_with_transition, false)
      blue_notifier.notify(change_transition)      
    end
    
  end
    
  describe "transitions" do

    subject do
      objekt = BluepillHipChatNotifier.new(fake_process, :api_token => "sample", :room_id => 12345, :from => "Bluepill - sample")
      objekt.stub(:hipchat_client) { hipchatclient }
      objekt
    end  
  
    it "should not notice if transition is not changing" do
      subject.should_not_receive(:send_message)
      subject.notify(no_change_transition)
    end

    it "should notice if transition is changing" do
      subject.should_not_receive(:send_message).with(default_message_with_transition, false)
      subject.notify(no_change_transition)
    end  
  end
  
end
