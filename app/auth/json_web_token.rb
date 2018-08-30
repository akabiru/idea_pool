class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  BaseError = Class.new(StandardError)

  InvalidToken = Class.new(BaseError)
  MissingToken = Class.new(BaseError)

  class << self
    def encode(payload)
      JWTSessions::Session.new(payload: payload)
    end
  end
end
