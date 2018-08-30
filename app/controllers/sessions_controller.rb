class SessionsController < ApplicationController
  skip_before_action :authorize_api_request

  def create
    user = AuthenticateUser.login(
      session_params[:email], session_params[:password]
    )
    session = JsonWebToken.decode(user_id: user.id)
    login = session.login
    json_response credentials(login)
  end

  def refresh
    authorize_refresh_request!
    session = JsonWebToken.refresh(payload)
    refresh = session.refresh(found_token)
    json_response(jwt: refresh[:access])
  end

  def destroy
    JsonWebToken.flush!(payload['uid'])
    head :no_content
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
