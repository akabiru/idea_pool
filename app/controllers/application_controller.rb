class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include ExceptionHandler
  include Response

  before_action :authorize_api_request
  attr_reader :current_user

  private

  def authorize_api_request
    authorize_access_request!
    @current_user = AuthorizeApiRequest.authorize!(payload)
  end
end
