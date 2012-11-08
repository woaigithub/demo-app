require 'spec_helper'

describe "UserPages" do

  subject { page }
  describe "signup pages" do
 
    before { visit signup_path }

    it { should have_selector("h1", text: 'sign up') }
    it { should have_selector('title', text: 'sign up') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
 
    it { should have_selector("h1", :text => user.name) }
    it { should have_selector("title", :text => user.name) }
  end
end
