class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    return render json: { errors: 'You must login to consult this information' }, status: :unauthorized unless header
    
    decoded = jwt_decode(header)
    @current_user = Employee.find(decoded[:user_id]) if decoded

    return render json: { errors: 'Caducated session, please, login again' }, status: :unauthorized unless @current_user
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
