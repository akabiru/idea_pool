# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_api_request, only: %i[create login]

  def create
    user = User.create!(user_params)
    session = AuthenticateUser.authenticate!(user.email, user.password)
    login = session.login
    json_response(credentials(login), :created)
  end

  def login
    user = AuthenticateUser.login(user_params[:email], user_params[:password])
    session = JsonWebToken.decode(user_id: user.id)
    login = session.login
    json_response credentials(login)
  end

  def me
    json_response(
      email: current_user.email,
      name: current_user.name,
      avatar_url: current_user.avatar_url
    )
  end

  private

  def credentials(login)
    { jwt: login[:access], refresh_token: login[:refresh] }
  end

  def user_params
    params.permit(:email, :name, :password, :password_confirmation)
  end
end
