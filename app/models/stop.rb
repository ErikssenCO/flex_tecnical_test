class Stop < ApplicationRecord
  belongs_to :location
  belongs_to :manifest

  enum :status, {
    pending: 0,
    in_route: 1,
    complete: 2,
    skipped: 3,
    failed: 4,
    removed: 5
    }, prefix: true

  before_save :set_position, :change_status

  def set_position
    last_stop = manifest.stops.order(position: :desc).first
    self.position = last_stop ? last_stop.position + 1 : 1
  end

  def change_status
    self.status = Stop.statuses[:pending] if manifest.status_pending? || manifest.status_scheduled?
    self.status = Stop.statuses[:in_route] if manifest.status_in_route?
  end
end
