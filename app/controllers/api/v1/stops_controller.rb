class Api::V1::StopsController < ApplicationController

  before_action :get_stop, only: [:remove]
  before_action :validate_stop, only: [:create]

  def create
    @stop = Stop.new(stop_params)

    if @stop.save
      render json: { id: @stop.id, name: @stop.name }, status: :created
    else
      render json: { errors: @stop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def remove
    get_stop
    if @stop.removed!
      render json: { message: "Stop removed successfully." }, status: :ok
    else
      render json: { errors: @stop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def stop_params
    params.required(:stop).permit(:manifest_id, :location_id)
  end

  def get_stop
    @stop = Stop.find(params[:id])
  end

  def validate_stop
    manifest = Manifest.where(id: stop_params[:manifest_id]).first
    return render json: { errors: "manifest does not exist" } unless manifest

    location = Location.where(id: stop_params[:location_id]).first
    return render json: { errors: "location does not exist" } unless manifest

    manifest_locations = [manifest.original_location_id, manifest.destination_location_id]
    return render json: { errors: "must be either the original or destination location of the manifest" } unless manifest
  end
end
