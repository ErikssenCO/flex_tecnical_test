class SessionsController < ApplicationController

  skip_before_action :authenticate_request, only: [:create]

  def create
    @user = Employee.find_by(email: params[:email])
    return render json: { errors: 'User not found, create a new user.' }, status: :unauthorized if @user.nil?

    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)

      render json: { token: token }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
