require 'spec_helper'

describe "static pages" do

  describe "home page" do
    it "should have the content 'sample app'" do
      visit '/staticpages/home'
      page.should have_content('sample app')
      page.should have_selector("title", :text => "app")
    end
  end 

  describe 'help page' do

    it "should have the content 'helo'" do
      visit '/staticpages/help'
      page.should have_content('help')
    end
  end

  describe 'about' do
    it "should have the content 'about'" do
      visit '/staticpages/about'
      page.should have_content('about')
    end
  end
end
