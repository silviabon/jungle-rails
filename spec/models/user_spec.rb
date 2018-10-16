require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      user = User.new(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      user.should be_valid
    end

    it "is not valid without a password field" do
      user = User.new(name: "newUser", email: "a@a.a", password: "", password_confirmation: "password")
      user.should_not be_valid
    end

    it "is not valid without a password confirmation field" do
      user = User.new(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "")
      user.should_not be_valid
    end

    it "is not valid without a password confirmation field matching the password field" do
      user = User.new(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "passwordss")
      user.should_not be_valid
    end

    it "is not valid if email is not unique" do
      user = User.create(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      user2 = User.create(name: "newUser", email: "A@a.a", password: "password", password_confirmation: "password")
      user2.should_not be_valid
    end
    
    it "is not valid without a user name" do
      user = User.new(name: nil, email: "a@a.a", password: "password", password_confirmation: "password")
      user.should_not be_valid
    end

    it "should be not be valid with a short password" do
      user = User.new(name: "newUser", email: "a@a.a", password: 'short', password_confirmation: 'short')
      user.should_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate with right credentials" do
      user = User.create(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials(user.email, "password")).to be_a(User)
    end
    it "should not authenticate with wrong email" do
      user = User.create(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials("asa@a.a", "password")).not_to be_a(User)
    end
    it "should not authenticate with wrong password" do
      user = User.create(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials(user.email, "passworddd")).not_to be_a(User)
    end
    it "should authenticate with spaces before and after email" do
      user = User.create(name: "newUser", email: "a@a.a", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials(" a@a.a ", "password")).to be_a(User)
    end
    it "should authenticate with email case-insensitive" do
      user = User.create(name: "newUser", email: "a@a.A", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials("A@a.a", "password")).to be_a(User)
    end
  end

end

