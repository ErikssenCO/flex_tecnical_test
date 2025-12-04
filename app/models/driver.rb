class Driver < ApplicationRecord
  has_many :manifests

  enum :status, {
    active: 0,
    inactive: 1,
    suspended: 2
    }, prefix: true

    def is_active?
      self.status_active?
    end
end
