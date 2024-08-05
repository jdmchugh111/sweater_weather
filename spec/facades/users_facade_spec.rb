require "rails_helper"

RSpec.describe UsersFacade do
  it "exists" do
    facade = UsersFacade.new
    expect(facade).to be_a UsersFacade
  end

  describe "#create_user" do
    it "can create a new user" do
      facade = UsersFacade.new
      password = Faker::Internet.password
      
      user = facade.create_user(Faker::Internet.email, password, password)
      expect(user).to be_a User
    end
  end
end