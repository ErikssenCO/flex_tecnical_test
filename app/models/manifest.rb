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
end
