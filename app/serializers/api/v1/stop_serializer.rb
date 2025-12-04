class Api::V1::StopSerializer < ActiveModel::Serializer
  attributes :id,
             :location,
             :status,
             :created_at,
             :updated_at

  def location
    stop.location.name
  end

  def status
    stop.status
  end

  private

  def stop
    object
  end
end