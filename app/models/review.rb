class Review < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
end


