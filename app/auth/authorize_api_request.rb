class AuthorizeApiRequest
  AuthorizationError = Class.new(StandardError)

  attr_reader :payload

  def self.authorize!(payload)
    new(payload).user
  end

  def initialize(payload)
    @payload = payload || {}
  end

  def user
    @_user ||= User.find(payload['user_id'])
  rescue ActiveRecord::RecordNotFound
    raise JsonWebToken::InvalidToken, Message::INVALID_TOKEN
  end
end
