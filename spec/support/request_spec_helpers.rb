# frozen_string_literal: true

module RequestSpecHelpers
  def expired_token_generator
    JsonWebToken.encode({ user_id: user.id }, (Time.now.to_i - 1_000_000))
  end

  def json
    JSON.parse(response.body)
  end

  def token_generator
    JsonWebToken.encode(user_id: user.id)
  end

  def access_token
    token_generator.login[:access]
  end

  def valid_headers
    {
      'Authorization' => "Bearer #{access_token}",
      'Content-Type'  => 'application/json'
    }
  end

  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end
end
