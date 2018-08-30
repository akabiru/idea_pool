module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from AuthenticateUser::AuthenticationError,
                with: :unauthorized_request
    rescue_from JsonWebToken::BaseError, with: :four_twenty_two
    rescue_from JWTSessions::Errors::Unauthorized, with: :unauthorized_request
  end

  private

  def four_twenty_two(exception)
    json_response({ message: exception.message }, :unprocessable_entity)
  end

  def unauthorized_request(exception)
    json_response({ message: exception.message }, :unauthorized)
  end

  def not_found(exception)
    json_response({ message: exception.message }, :not_found)
  end
end
