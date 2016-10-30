require 'rails_helper'

RSpec.describe "sign up and sign in routing", :type => :routing do
  it "routes /signup to users#new" do
    expect(:get => "/signup").to route_to(
                                      :controller => "users",
                                      :action => "new"
                                  )
  end
  it "routes /login to sessions#new" do
    expect(:get => "/login").to route_to(
                                      :controller => "sessions",
                                      :action => "new"
                                  )
  end

end
