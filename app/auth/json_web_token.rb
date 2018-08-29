class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  BaseError = Class.new(StandardError)

  InvalidToken = Class.new(BaseError)
  MissingToken = Class.new(BaseError)

  class << self
    def encode(sub, exp = 10.minutes.from_now)
      payload = {
        iss: 'https://idea-pool.herokuapp.com', # TODO: Set from host
        sub: sub,
        iat: Time.zone.now.to_i,
        # aud: '', TODO: Get from allowlist
        exp: exp.to_i,
        jti: SecureRandom.uuid
      }

      JWT.encode(payload, HMAC_SECRET)
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
