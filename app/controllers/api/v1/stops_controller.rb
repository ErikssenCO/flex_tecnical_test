class Api::V1::StopsController < ApplicationController
  before_action :get_stop, only: [:remove, :complete]
  before_action :validate_stop, only: [:create]

  def create
    @stop = Stop.new(stop_params)

    if @stop.save!
      render json: @stop, serializer: ::Api::V1::StopSerializer, status: :created
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

  def complete
    success, message = @stop.complete
    if success
      render json: @stop, serializer: ::Api::V1::StopSerializer, status: :ok
    else
      render json: { errors: message || @stop.errors.full_messages }, status: :unprocessable_entity
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
    manifest_stop_locations = manifest.stops.pluck(:location_id)
    if manifest_stop_locations.include?(location.id) || manifest_locations.include?(location.id)
      return render json: { errors: "Location already exists in manifest" }
    end

    invalid_statuses = Manifest.statuses.slice(:completed, :cancelled, :failed)
    if invalid_statuses.key?(manifest.status)
      return render json: { errors: "cannot add stop to manifest with status #{manifest.status}" }
    end
  end
end
