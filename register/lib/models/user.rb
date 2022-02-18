class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :address
  validates_uniqueness_of :username

  before_validation :set_password


  def authenticate?(address:)
    BCrypt::Password.new(password_digest) == address
  end

  private

  def set_password
    self.password = address
  end
end
