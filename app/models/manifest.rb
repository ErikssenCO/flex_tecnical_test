class Manifest < ApplicationRecord
  belongs_to :driver
  belongs_to :vehicle
  belongs_to :created_by, class_name: "Employee", foreign_key: "created_by_id"
  belongs_to :original_location, class_name: "Location"
  belongs_to :destination_location, class_name: "Location"

  has_many :stops

  enum :status, {
    scheduled: 0,
    in_route: 1,
    pending: 2,
    completed: 3,
    cancelled: 4,
    failed: 5
    }, prefix: true

  scope :in_route_with_last_stop_completed, -> {
    last_stops = Stop
    .select("DISTINCT ON (manifest_id) manifest_id, id, status")
    .where(status: 2)
    .order("manifest_id, position DESC")
    .to_sql

  joins("INNER JOIN (#{last_stops}) last_stop ON manifests.id = last_stop.manifest_id")
    .where(status: :in_route)
    .distinct
  }

  def save_manifest(employee:)
    vehicle = Vehicle.where(id: vehicle_id).first
    return [false, "Vehicle not found"] unless vehicle

    vehicle_is_active = vehicle.is_active?
    return [false, "Vehicle is not active"] unless vehicle_is_active

    driver = Driver.where(id: driver_id).first
    return [false, "Driver not found"] unless driver

    driver_is_active = driver.is_active?
    return [false, "Driver is not active"] unless driver_is_active

    self.created_by = employee

    [save!, nil]
  end

  def start_route
    return [false, "Manifest already started"] if started_at.present?

    self.status = Manifest.statuses[:in_route]
    self.started_at = Time.zone.now

    start_stops

    [save!, nil]
  end 

  def start_stops
    pending_stops = stops.status_pending
    pending_stops.each(&:status_in_route!)
  end
end
