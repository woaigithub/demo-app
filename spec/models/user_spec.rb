# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#


require 'spec_helper'

describe User do
  before { @user=User.new(:name=>"haha",:email=>"123@asdf.com",:password=>"123",
                          :password_confirmation=>"123") }

  subject { @user }

  let(:found_user) { User.find_by_email(@user.email) }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name=" " }

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email=nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do 
    before { @user.name="a"*50 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses=%w[user@foo,com user_at.org eadf.df@foo.foo@bar.com foo@ba+sdf.com]
      addresses.each do |invalid_address|
        @user.email=invalid_address
        @user.should_not be_valid
      end
    end
  end 

  describe "when email format is valid" do
    it "should be valid" do
      addresses=%w[user@foo.com user_@.org eadf.dffoo.foo@bar.com foo@basdf.com]
      addresses.each do |valid_address|
        @user.email=valid_address
        @user.should be_valid
      end
    end
  end


  describe "when email address is already taken" do
    before do
      user_with_same_email=@user.dup
      user_with_same_email.email=@user.email.upcase
      user_with_same_email.save
    end
    it { shoud_not be_valid }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }
    it { should_not ==user_for_invalid_password }
    specify { user_for_invalid_password.should be_false }
  end
 
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "create account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      befor do
        fill_in "Name", :with => "ronghu"
        fill_in "Email", :with => "asdf@123.com"
        fill_in "Password", :with => "123456"
        fill_in "Confirmation", :with => "123456"
      end

      if "should create a user" do
       expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  
#  pending "add some examples to (or delete) #{__FILE__}"
end


