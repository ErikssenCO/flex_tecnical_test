class ::Api::V1::ManifestSerializer < ActiveModel::Serializer
  attributes :id,
             :scheduled_start_at,
             :scheduled_end_at,
             :original_location,
             :destination_location,
             :driver,
             :vehicle,
             :created_by

  has_many :stops

  def scheduled_start_at
    manifest.scheduled_start_at.strftime("%d/%m/%Y %H:%M %p")
  end

  def scheduled_end_at
    manifest.scheduled_end_at.strftime("%d/%m/%Y %H:%M %p")
  end

  def original_location
    manifest.original_location.name
  end

  def destination_location
    manifest.destination_location.name
  end

  def driver
    manifest.driver.name
  end

  def vehicle
    manifest.vehicle.plate
  end

  def created_by
    manifest.created_by.name
  end

  private

  def manifest
    object
  end
end