require "spec_helper"

describe "DatabaseValidation" do
  after do
    User.delete_all
    Person.delete_all
  end
  
  context "checking for presence" do
    let(:user) { User.new }

    %w[username password].each do |attribute|
      it "should result can't be blank for #{attribute}" do
        user.should have(1).error_on(attribute)
        user.errors[attribute].should == [I18n.t("errors.messages.blank")]
      end
    end
  end
  
  context "checking for length" do
    let(:user) { User.new :username => "This login is too long", :password => "P4ss" }
    
    it "should add error" do
      user.should have(1).error_on(:username)
      user.errors[:username].should == [I18n.t("errors.messages.too_long", :count => 20)]
    end
  end
  
  context "checking for uniqueness" do
    it "should raise for duplicated" do
      expect {
        User.create!(:username => "username", :password => "P4ss")
      }.to_not raise_error
      
      expect {
        User.create!(:username => "username", :password => "P4ss")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  context "checking for belongs to" do
    let(:user) { User.create :username => "username", :password => "P4ss" }
    let(:person) { Person.create! :fullname => "Full Name", :user => user }
    
    it "should associate successfully" do
      expect {
        @person = Person.create! :fullname => "Full Name", :user => user
      }.to_not raise_error
    end
    
    it "should result direct association" do
      person.user.should == user
    end
  end
end
