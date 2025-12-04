class Stop < ApplicationRecord
  belongs_to :location
  belongs_to :manifest

  enum :status, {
    pending: 0,
    complete: 1,
    skipped: 2,
    failed: 3,
    removed: 4
    }, prefix: true

  before_save :set_position

  def set_position
    last_stop = manifest.stops.order(position: :desc).first
    self.position = last_stop ? last_stop.position + 1 : 1
  end

  def change_status
    status_pending! if manifest.status_pending? || manifest.status_scheduled?
    status_in_route! if manifest.status_in_route?
  end
end
