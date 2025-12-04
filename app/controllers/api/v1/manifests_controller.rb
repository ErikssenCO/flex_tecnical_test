class Api::V1::ManifestsController < ApplicationController

  before_action :get_manifest, only: [:show]

  def index
    @manifests = Manifest.all
    render json: @manifests, status: :ok
  end

  def show
    render json: @manifest, serializer: ::Api::V1::ManifestSerializer, status: :ok
  end

  def create
    @manifest = Manifest.new(manifest_params)
    @manifest.created_by = @current_user

    if @manifest.save
      render json: @manifest, status: :created
    else
      render json: { errors: @manifest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def manifest_params
    params.required(:manifest).permit(:driver_id, :vehicle_id, :original_location_id, :destination_location_id, :scheduled_start_at, :scheduled_end_at)
  end

  def get_manifest
    @manifest = Manifest.find(params[:id])
  end
end
