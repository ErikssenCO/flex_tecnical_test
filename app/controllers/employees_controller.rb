class EmployeesController < ApplicationController
  before_action :get_user, only: [:show]

  # GET /employees
  def index
    @employees = Employee.all
    render json: @employees, status: :ok
  end
  
  # GET /employees/:id
  def show
    render json: @employee, status: :ok
  end

  # POST /employee
  def create
    @employee = Employee.new(user_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:employee).permit(:name, :email, :password, :fiscal_number)
  end

  def get_employee
    @employee = Employee.find(params[:id])
  end
end
