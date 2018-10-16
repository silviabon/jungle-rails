require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      category = Category.new
      product = Product.new(name: "towel", price: 4, quantity: 10, category: category)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      category = Category.new
      product = Product.new(name: nil, price: 4, quantity: 10, category: category)
      expect(product).to_not be_valid
    end
    it "is not valid without a price" do
      category = Category.new
      product = Product.new(name: "towel", price: nil, quantity: 10, category: category)
      expect(product).to_not be_valid
    end
    it "is not valid without a quantity" do
      category = Category.new
      product = Product.new(name: "towel", price: 4, quantity: nil, category: category)
      expect(product).to_not be_valid
    end
    it "it not valid without a category" do
      product = Product.new(name: "towel", price: 4, quantity: 10, category: nil)
      expect(product).to_not be_valid
    end
  end
end
