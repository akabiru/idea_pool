# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_api_request, only: :create

  def create
    user = User.create!(signup_params)
    access_token = AuthenticateUser.authenticate!(user.email, user.password)
    # TODO: refresh_token
    json_response({ access_token: access_token }, :created)
  end

  def me
    json_response(
      email: current_user.email,
      name: current_user.name,
      avatar_url: current_user.avatar_url
    )
  end

  private

  def signup_params
    params.permit(:email, :name, :password, :password_confirmation)
  end
end
