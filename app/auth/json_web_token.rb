class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  BaseError = Class.new(StandardError)

  InvalidToken = Class.new(BaseError)
  MissingToken = Class.new(BaseError)

  class << self
    def encode(payload)
      JWTSessions::Session.new(payload: payload)
    end

    def decode(token)
      body = JWT.decode(token, HMAC_SECRET, true, decode_options)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError => exception
      raise InvalidToken, "#{Message::INVALID_TOKEN}: #{exception.message}"
    end

    private

    def decode_options
      {
        verify_iss: true,
        verify_iat: true,
        leeway: 30,
        algorithm: 'HS256'
      }
    end
  end
end
