require 'spec_helper'

describe "UserPages" do
   subject { page }
   

  describe "sign up" do
      before { visit signup_path }
      it {should have_content "Sign up"}
    end
  end