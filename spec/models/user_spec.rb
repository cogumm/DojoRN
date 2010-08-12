require 'spec_helper'

describe User do

  before(:each) do
    @twitter = Twitter.stub!( :user ) { |username| raise Twitter::NotFound unless username == "cogumm" } 
  end
  
  subject do
    User.new(:twitter => "cogumm")
  end

  it { should be_valid }

  it "should not be valid without twitter" do
    subject.twitter = nil
    subject.should_not be_valid
  end

  it "should have a unique twitter" do
    subject.save
    user = User.new(:twitter => "cogumm")
    user.should_not be_valid
  end
  
  it "should check on twitter before save" do
    lambda { subject.save }.should_not raise_error(Twitter::NotFound)
    lambda { User.create(:twitter => "cogumm000") }.should raise_error(Twitter::NotFound)
  end
  
  it "should respond to avatar_url" do
    Twitter.should_receive(:user).with("cogumm").and_return({'profile_image_url' => "http://twitter.com/avatars/cogumm.jpg"})
    subject.avatar_url.should == "http://twitter.com/avatars/cogumm.jpg"
  end
end