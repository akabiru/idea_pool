class AuthorizeApiRequest
  AuthorizationError = Class.new(StandardError)

  def self.authorize!(headers)
    new(headers).user
  end

  def initialize(headers)
    @headers = headers || {}
  end

  def user
    return unless decoded_access_token
    @_user ||= User.find(decoded_access_token[:sub][:user_id])
  rescue ActiveRecord::RecordNotFound
    raise JsonWebToken::InvalidToken, Message::INVALID_TOKEN
  end

  private

  attr_reader :headers

  def decoded_access_token
    @decoded_access_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    auth_headers = headers['Authorization']

    if auth_headers.blank?
      raise JsonWebToken::MissingToken, Message::MISSING_TOKEN
    end

    auth_headers.split(' ').last
  end
end
