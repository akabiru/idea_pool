class RefreshController < ApplicationController
  skip_before_action :authorize_api_request
  before_action :authorize_refresh_request!

  def create
    session = JsonWebToken.refresh(payload)
    refresh = session.refresh(found_token)
    json_response(jwt: refresh[:access])
  end

  def destroy
    JsonWebToken.flush!(payload['uid'])
    head :no_content
  end
end
