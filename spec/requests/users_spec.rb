require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "on success" do

      it "should create a new user" do
        lambda do
            visit signup_path
            fill_in :user_name,                   :with => "Roman Zolin"
            fill_in :user_email,                  :with => "rzolin@gmail.com"
            fill_in :user_password,               :with => "654321"
            fill_in :user_password_confirmation,  :with => "654321"
            click_button
            response.should_not have_selector('div#error_explanation')
            response.should have_selector('div.flash.success', :content => 'Your account was successfuly created!')
            response.should render_template('users/new')
          end.should change(User, :count).by(1)
      end
      
    end

    describe "on failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name,                  :with => ""
          fill_in :user_email,                 :with => ""
          fill_in :user_password,              :with => ""
          fill_in :user_password_confirmation, :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
      
    end
    
  end

end
