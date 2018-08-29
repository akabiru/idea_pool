class AuthenticateUser
  AuthenticationError = Class.new(StandardError)

  def self.authenticate!(email, password)
    new(email, password).authenticate!
  end

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate!
    JsonWebToken.encode(user_id: auth_user.id) if auth_user
  end

  private

  attr_reader :email, :password

  def auth_user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)
    raise AuthenticationError, Message::INVALID_CREDENTIALS
  end
end
