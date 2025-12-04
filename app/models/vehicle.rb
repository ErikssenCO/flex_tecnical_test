class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  has_many :manifests

  enum :status, {
    active: 0,
    inactive: 1,
    suspended: 2,
    maintenance: 3
    }, prefix: true

    def is_active?
      self.status_active?
    end
end
