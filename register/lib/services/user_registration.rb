class UserRegistration

  attr_reader :username, :address, :errors, :user

  def initialize(username:, address:)
    @username = username
    @address = address
    @errors = []
  end

  def call
    @user = User.find_by(username: username)
    create_user! unless user
    @errors << 'wrong address' if !user.authenticate?(address: address)

  rescue => e
    errors << e.message
  end

  def create_user!
    @user = User.create!(
      username: username,
      address: address
    )
  end

  def success?
    errors == []
  end
end
