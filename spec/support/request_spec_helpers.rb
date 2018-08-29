module RequestSpecHelpers
  def json
    JSON.parse(response.body)
  end

  def token_generator
    JsonWebToken.encode(user_id: user.id)
  end

  def valid_headers
    {
      'Authorization' => token_generator,
      'Content-Type'  => 'application/json',
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end
