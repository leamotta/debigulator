class ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  protected

  def record_not_found
    render json: { errors: 'Record was not found' }, status: :not_found
  end

  def parameter_missing(error)
    render json: {
      errors: 'Parameter missing: ' + error.param.to_s
    }, status: :bad_request
  end

  def unprocessable_entity(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def bad_request(errors)
    render json: { errors: errors }, status: :bad_request
  end

  def unauthorized(errors)
    render json: { errors: errors }, status: :unauthorized
  end

  def authenticate_request
    unauthorized('Invalid token') unless valid_token
  end

  # Move this to a PORO if it grows
  def valid_token
    Partner.exists?(token: request.headers['Auth-Key'])
  end
end
