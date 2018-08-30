class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  BaseError = Class.new(StandardError)

  InvalidToken = Class.new(BaseError)
  MissingToken = Class.new(BaseError)
  TokenFlashFailure = Class.new(BaseError)

  class << self
    def encode(payload)
      JWTSessions::Session.new(payload: payload)
    end

    alias decode encode

    def refresh(payload)
      access_payload = { key: payload[:key] }
      JWTSessions::Session.new(payload: access_payload, refresh_payload: payload)
    end

    def flush!(uid)
      flushed = JWTSessions::Session.new.flush_by_uid(uid)
      return true if flushed.positive?
      raise TokenFlashFailure, Message::LOGOUT_FAILURE
    end
  end
end
