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
