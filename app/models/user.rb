class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  before_save :to_lower

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.squish.downcase)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  private

  def to_lower
    self.email = self.email.downcase
  end
end
