require 'spec_helper'

describe PagesController do
  render_views
  #2012-12-6/11:00
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  #2012-12-6/09:00
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",:content => "#{@base_title} | Home")
    end

    it "should have a non-blank body" do
      get 'home'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
  end  
  #2012-12-6/09:00
  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",:content => "#{@base_title} | Contact")
    end
  end
  #2012-12-6/09:00
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",:content => "#{@base_title} | About")
    end
  end
end