class UserTokenController < ApplicationController
  def create
    user = User.create!(signup_params)
    access_token = AuthenticateUser.authenticate!(user.email, user.password)
    # TODO: refresh_token
    json_response({ access_token: access_token }, :created)
  end

  private

  def signup_params
    params.permit(:email, :name, :password, :password_confirmation)
  end
end
