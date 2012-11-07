require 'spec_helper'

describe "static pages" do


  subject { page }

  describe "home page" do

    before { visit root_path }

    it { should have_selector("h1", text: "sample app") }
    it { should have_selector 'title',
                              text: "ruby on rails tutorial sample app" }
    it { should_not have_selector 'title', text: '|home' }
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
